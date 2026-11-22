const db = require('../config/data_base');

const PlayerLocation = {
  // Insere ou atualiza a posição já aproximada e renova o updated_at
  async upsert({ user_id, lat, lon }) {
    await db.query(
      `INSERT INTO player_locations (user_id, lat, lon)
       VALUES (?, ?, ?)
       ON DUPLICATE KEY UPDATE
         lat = VALUES(lat),
         lon = VALUES(lon),
         updated_at = CURRENT_TIMESTAMP`,
      [user_id, lat, lon]
    );
  },

  // Remove imediatamente quando o jogador desativa a disponibilidade
  async remove(user_id) {
    await db.query(
      'DELETE FROM player_locations WHERE user_id = ?',
      [user_id]
    );
  },

  // Garante reciprocidade: só considera ativo se o sinal for recente (10 min)
  async findByUserId(user_id) {
    const [rows] = await db.query(
      `SELECT user_id, lat, lon, updated_at
       FROM player_locations
       WHERE user_id = ?
         AND updated_at > (NOW() - INTERVAL 10 MINUTE)`,
      [user_id]
    );
    return rows[0] || null;
  },

  // Busca jogadores ativos por caixa aproximada (lat/lon) à volta do centro do utilizador
  async findNearby({ lat, lon, radius, excludeUserId, maxAgeMinutes = 10, limit = 50 }) {
    const dLat = radius / 111320;
    const cosLat = Math.cos((lat * Math.PI) / 180);
    const dLon = radius / (111320 * (Math.abs(cosLat) < 1e-6 ? 1e-6 : cosLat));

    const [rows] = await db.query(
      `SELECT pl.user_id, pl.lat, pl.lon, pl.updated_at, u.name, u.avatar
       FROM player_locations pl
       JOIN users u ON u.id = pl.user_id
       WHERE pl.user_id <> ?
         AND pl.updated_at > (NOW() - INTERVAL ? MINUTE)
         AND pl.lat BETWEEN ? AND ?
         AND pl.lon BETWEEN ? AND ?
       LIMIT ?`,
      [
        excludeUserId,
        maxAgeMinutes,
        lat - dLat,
        lat + dLat,
        lon - dLon,
        lon + dLon,
        limit,
      ]
    );
    return rows;
  },
};

module.exports = PlayerLocation;