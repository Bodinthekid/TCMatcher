const crypto = require('crypto');
const PlayerLocation = require('../models/PlayerLocation');

if (!process.env.LOCATION_SECRET) {
  console.warn('⚠️  LOCATION_SECRET não definido no .env: a aproximação de localização vai falhar.');
}

const GRID_METERS = 500;
const M_PER_DEG_LAT = 111320;

// Aproxima a coordenada para o centro de uma célula de 500 m,
// deslocada por HMAC com LOCATION_SECRET e userId (a posição exata nunca é guardada).
function coarsen(lat, lon, userId) {
  const h = crypto
    .createHmac('sha256', process.env.LOCATION_SECRET)
    .update(String(userId))
    .digest();

  const stepLat = GRID_METERS / M_PER_DEG_LAT;
  const cosLat = Math.cos((lat * Math.PI) / 180);
  const stepLon = GRID_METERS / (M_PER_DEG_LAT * (Math.abs(cosLat) < 1e-6 ? 1e-6 : cosLat));

  const offLat = (h.readUInt16BE(0) / 65535) * stepLat;
  const offLon = (h.readUInt16BE(2) / 65535) * stepLon;

  const cellLat = Math.floor((lat - offLat) / stepLat);
  const cellLon = Math.floor((lon - offLon) / stepLon);

  return {
    lat: (cellLat + 0.5) * stepLat + offLat,
    lon: (cellLon + 0.5) * stepLon + offLon,
  };
}

function haversineMeters(lat1, lon1, lat2, lon2) {
  const R = 6371000;
  const toRad = (d) => (d * Math.PI) / 180;
  const dLat = toRad(lat2 - lat1);
  const dLon = toRad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) ** 2;
  return 2 * R * Math.asin(Math.sqrt(a));
}

// PUT /api/players/me/location
exports.updateMyLocation = async (req, res) => {
  try {
    const userId = req.user.id; // sempre do token autenticado, nunca do body
    const lat = parseFloat(req.body.lat);
    const lon = parseFloat(req.body.lon);

    if (
      Number.isNaN(lat) ||
      Number.isNaN(lon) ||
      Math.abs(lat) > 90 ||
      Math.abs(lon) > 180
    ) {
      return res.status(400).json({ message: 'Coordenadas inválidas.' });
    }

    const coarse = coarsen(lat, lon, userId);
    await PlayerLocation.upsert({
      user_id: userId,
      lat: coarse.lat,
      lon: coarse.lon,
    });

    return res.status(200).json({ success: true });
  } catch (error) {
    console.error('Erro ao atualizar localização:', error.message);
    return res.status(500).json({ message: 'Erro interno.' });
  }
};

// DELETE /api/players/me/location
exports.stopSharing = async (req, res) => {
  try {
    await PlayerLocation.remove(req.user.id);
    return res.status(200).json({ success: true });
  } catch (error) {
    console.error('Erro ao parar partilha:', error.message);
    return res.status(500).json({ message: 'Erro interno.' });
  }
};

// GET /api/players/nearby
exports.getNearbyPlayers = async (req, res) => {
  try {
    const userId = req.user.id;

    // Reciprocidade: só vê jogadores quem também partilha localização recente
    const me = await PlayerLocation.findByUserId(userId);
    if (!me) {
      return res.status(403).json({
        message: 'Ativa a tua disponibilidade para ver jogadores por perto.',
      });
    }

    const parsedRadius = parseFloat(req.query.radius);
    const radius = Number.isNaN(parsedRadius)
      ? 5000
      : Math.min(Math.max(parsedRadius, 500), 10000);

    const rows = await PlayerLocation.findNearby({
      lat: me.lat,
      lon: me.lon,
      radius,
      excludeUserId: userId,
      maxAgeMinutes: 10,
      limit: 50,
    });

    const players = rows
      .map((p) => ({
        id: p.user_id,
        name: p.name,
        avatar: p.avatar,
        lat: p.lat,
        lon: p.lon,
        raw: haversineMeters(me.lat, me.lon, p.lat, p.lon),
        is_ready: true,
      }))
      .filter((p) => p.raw <= radius)
      .map(({ raw, ...p }) => ({
        ...p,
        distance_m: Math.max(500, Math.round(raw / 500) * 500),
      }));

    return res.status(200).json({
      success: true,
      count: players.length,
      players,
    });
  } catch (error) {
    console.error('Erro ao listar jogadores próximos:', error.message);
    return res.status(500).json({ message: 'Erro interno.' });
  }
};