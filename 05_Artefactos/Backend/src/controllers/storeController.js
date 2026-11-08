const axios = require('axios');
const Store = require('../models/Store');

// Listar todas as lojas (da Base de Dados MySQL)
exports.getAllStores = async (req, res) => {
  try {
    const stores = await Store.findAll();
    return res.status(200).json(stores);
  } catch (error) {
    console.error('Erro ao listar lojas:', error);
    return res.status(500).json({ message: 'Erro interno ao buscar lojas.', error: error.message });
  }
};

// Obter loja por ID do utilizador (da Base de Dados MySQL)
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

// 🌍 Pesquisar lojas próximas (Com Cache no MySQL e Fallback na Overpass API)
exports.getNearbyStores = async (req, res) => {
  try {
    const { lat, lon, radius = 5000 } = req.query;

    if (!lat || !lon) {
      return res.status(400).json({ message: 'Latitude e longitude são obrigatórias.' });
    }

    const targetLat = parseFloat(lat);
    const targetLon = parseFloat(lon);
    const maxRadiusMeters = parseFloat(radius);

    // 1. TENTAR BUSCAR NO MYSQL PRIMEIRO (Cache local ultra-rápida)
    let allStores = [];
    try {
      allStores = await Store.findAll();
    } catch (dbErr) {
      console.log('Aviso: Não foi possível ler do MySQL, a prosseguir para a API externa.');
    }

    // Função auxiliar para calcular a distância em metros (Fórmula de Haversine)
    function calculateDistance(lat1, lon1, lat2, lon2) {
      const R = 6371e3; // Raio da Terra em metros
      const dLat = (lat2 - lat1) * Math.PI / 180;
      const dLon = (lon2 - lon1) * Math.PI / 180;
      const a = 
        Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) * 
        Math.sin(dLon/2) * Math.sin(dLon/2);
      const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
      return R * c;
    }

    // Filtra as lojas locais que estão dentro do raio pretendido
    let nearbyStores = allStores.filter(store => {
      const dist = calculateDistance(targetLat, targetLon, store.lat, store.lon);
      return dist <= maxRadiusMeters;
    });

    // 2. FALLBACK: Se o MySQL ainda não tiver lojas nesta zona, vai buscar à Overpass API
    if (nearbyStores.length === 0) {
      console.log('🔄 Cache vazia para esta zona. A consultar a Overpass API...');

      const overpassQuery = `
        [out:json][timeout:25];
        (
          node["shop"="hobby"](around:${maxRadiusMeters},${targetLat},${targetLon});
          node["shop"="games"](around:${maxRadiusMeters},${targetLat},${targetLon});
          node["trading_cards"="yes"](around:${maxRadiusMeters},${targetLat},${targetLon});
        );
        out body;
      `;

      const response = await axios.post('https://overpass.openstreetmap.fr/api/interpreter', overpassQuery, {
        headers: {
          'Content-Type': 'text/plain',
          'User-Agent': 'TCMatcherApp/1.0 (contato@tcmatcher.com)'
        }
      });

      const fetchedStores = response.data.elements
        .filter(el => el.tags && el.tags.name)
        .map(el => ({
          id: el.id,
          name: el.tags.name,
          lat: el.lat,
          lon: el.lon,
          address: el.tags['addr:street'] || 'Localização comercial'
        }));

      nearbyStores = fetchedStores;
    } else {
      console.log('⚡ Lojas carregadas instantaneamente da Cache MySQL!');
    }

    return res.status(200).json({
      success: true,
      count: nearbyStores.length,
      stores: nearbyStores
    });

  } catch (error) {
    console.error('Erro ao buscar lojas próximas:', error);
    return res.status(500).json({ 
      message: 'Erro interno ao buscar lojas próximas.', 
      error: error.message 
    });
  }
};