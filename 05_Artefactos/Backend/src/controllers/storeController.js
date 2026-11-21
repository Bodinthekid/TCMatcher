const axios = require('axios');
const Store = require('../models/Store');

const BLOCKED_NAME_PATTERNS = [
  /\bfnac\b/,
  /\bcontinente\b/,
  /\bcex\b/,
  /books/,
];

// Cache simples em memória (TTL de 5 minutos)
const NEARBY_CACHE_TTL_MS = 5 * 60 * 1000;
const nearbyStoresCache = new Map();

function isBlockedStoreName(name = '') {
  const normalized = String(name)
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();

  return BLOCKED_NAME_PATTERNS.some((regex) => regex.test(normalized));
}

function getCacheKey(lat, lon) {
  // Arredonda a ~1 km (2 casas decimais) para reutilizar resultados próximos
  const rLat = Number(lat).toFixed(2);
  const rLon = Number(lon).toFixed(2);
  return `${rLat}:${rLon}`;
}

// Listar todas as lojas parceiras
exports.getAllStores = async (req, res) => {
  try {
    const stores = await Store.findAll();
    return res.status(200).json(stores);
  } catch (error) {
    console.error('Erro ao listar lojas:', error);
    return res.status(500).json({ message: 'Erro interno ao buscar lojas.', error: error.message });
  }
};

// Obter loja parceira por ID do utilizador
exports.getStoreByUserId = async (req, res) => {
  try {
    const { userId } = req.params;
    const store = await Store.findByUserId(userId);

    if (!store) {
      return res.status(404).json({ message: 'Loja não encontrada para este utilizador.' });
    }

    return res.status(200).json(store);
  } catch (error) {
    console.error('Erro ao buscar loja:', error);
    return res.status(500).json({ message: 'Erro interno ao buscar loja.', error: error.message });
  }
};

// 🌍 Pesquisa otimizada utilizando a nova Google Places API (New)
exports.getNearbyStores = async (req, res) => {
  try {
    const { lat, lon } = req.query;

    const parsedLat = parseFloat(lat);
    const parsedLon = parseFloat(lon);

    if (Number.isNaN(parsedLat) || Number.isNaN(parsedLon)) {
      return res.status(400).json({ message: 'Latitude e longitude válidas são obrigatórias.' });
    }

    const apiKey = process.env.GOOGLE_MAPS_API_KEY;
    if (!apiKey) {
      return res.status(500).json({ message: 'Chave da API do Google Maps não configurada no servidor.' });
    }

    const cacheKey = getCacheKey(parsedLat, parsedLon);
    const cached = nearbyStoresCache.get(cacheKey);
    if (cached && cached.expiresAt > Date.now()) {
      return res.status(200).json({
        success: true,
        count: cached.stores.length,
        stores: cached.stores,
        cached: true,
      });
    }

    const searchQueries = [
      'lojas tcg',
      'card game store',
      'mercadia games',
      'versus game center',
    ];

    const url = 'https://places.googleapis.com/v1/places:searchText';
    const headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      'X-Goog-FieldMask': 'places.id,places.displayName,places.formattedAddress,places.location,places.rating',
    };

    const requests = searchQueries.map((q) =>
      axios.post(
        url,
        {
          textQuery: q,
          locationBias: {
            circle: {
              center: {
                latitude: parsedLat,
                longitude: parsedLon,
              },
              radius: 15000.0,
            },
          },
        },
        {
          headers,
          timeout: 6000,
        }
      )
    );

    const results = await Promise.allSettled(requests);
    const uniqueStoresMap = new Map();

    results.forEach((result, index) => {
      if (result.status === 'rejected') {
        const err = result.reason;
        console.error(`Erro na query ${searchQueries[index]} (Places New):`, err?.response?.data || err?.message);
        return;
      }

      const places = result.value?.data?.places;
      if (!Array.isArray(places)) return;

      for (const place of places) {
        if (!place?.id) continue;
        if (isBlockedStoreName(place.displayName?.text)) continue;

        if (!uniqueStoresMap.has(place.id)) {
          uniqueStoresMap.set(place.id, {
            id: place.id,
            name: place.displayName?.text || 'Loja TCG',
            lat: place.location?.latitude,
            lon: place.location?.longitude,
            address: place.formattedAddress || 'Morada comercial',
            rating: place.rating || 0.0,
            is_verified: false,
          });
        }
      }
    });

    const stores = Array.from(uniqueStoresMap.values());

    nearbyStoresCache.set(cacheKey, {
      stores,
      expiresAt: Date.now() + NEARBY_CACHE_TTL_MS,
    });

    return res.status(200).json({
      success: true,
      count: stores.length,
      stores,
    });
  } catch (error) {
    console.error('Erro ao consultar a nova Google Places API:', error.response?.data || error.message);
    return res.status(500).json({
      message: 'Erro interno ao buscar lojas no Google Maps.',
      error: error.response?.data || error.message,
    });
  }
};

// 🔐 Reivindicar uma loja do mapa
exports.claimStore = async (req, res) => {
  try {
    const { userId, storeMapId, phone, openingHours, storeName, address } = req.body;

    if (!userId || !storeMapId) {
      return res.status(400).json({ message: 'User ID e Store Map ID são obrigatórios.' });
    }

    await Store.create({
      user_id: userId,
      store_map_id: storeMapId,
      store_name: storeName || 'Loja Parceira',
      address: address || 'Morada não especificada',
      phone: phone || '',
      opening_hours: openingHours || '',
      status: 'approved',
    });

    return res.status(201).json({
      success: true,
      message: 'Loja reivindicada com sucesso! Agora és o gestor oficial.',
    });
  } catch (error) {
    console.error('Erro ao reivindicar loja:', error);
    return res.status(500).json({ message: 'Erro interno ao reivindicar loja.', error: error.message });
  }
};