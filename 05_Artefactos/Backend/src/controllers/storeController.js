const axios = require('axios');
const Store = require('../models/Store');

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

    if (!lat || !lon) {
      return res.status(400).json({ message: 'Latitude e longitude são obrigatórias.' });
    }

    const apiKey = process.env.GOOGLE_MAPS_API_KEY;
    if (!apiKey) {
      return res.status(500).json({ message: 'Chave da API do Google Maps não configurada no servidor.' });
    }

    // Termos de busca para a nova API
    const searchQueries = [
      'lojas tcg ',
      'card game store ',
      'mercadia games',
      'versus game center'
    ];

    let allPlaces = [];

    // O endpoint da nova API (Places API New) usa POST com um corpo JSON e cabeçalhos específicos
    for (const q of searchQueries) {
      try {
        const url = `https://places.googleapis.com/v1/places:searchText`;
        
        const response = await axios.post(
          url,
          {
            textQuery: q,
            locationBias: {
              circle: {
                center: {
                  latitude: parseFloat(lat),
                  longitude: parseFloat(lon)
                },
                radius: 15000.0
              }
            }
          },
          {
            headers: {
              'Content-Type': 'application/json',
              'X-Goog-Api-Key': apiKey,
              'X-Goog-FieldMask': 'places.id,places.displayName,places.formattedAddress,places.location,places.rating'
            }
          }
        );
        
        if (response.data && response.data.places) {
          // Mapeia o formato da nova API para a estrutura que o teu frontend espera
          const formattedPlaces = response.data.places.map(place => ({
            id: place.id,
            name: place.displayName?.text || 'Loja TCG',
            lat: place.location?.latitude,
            lon: place.location?.longitude,
            address: place.formattedAddress || 'Morada comercial',
            rating: place.rating || 0.0,
            is_verified: false,
          }));
          allPlaces.push(...formattedPlaces);
        }
      } catch (err) {
        console.error(`Erro na query ${q} (Places New):`, err.response?.data || err.message);
      }
    }

    // Remove duplicados com base no ID único do lugar
    const uniqueStoresMap = new Map();
    allPlaces.forEach(store => {
      if (store.id) {
        uniqueStoresMap.set(store.id, store);
      }
    });

    const stores = Array.from(uniqueStoresMap.values());

    return res.status(200).json({
      success: true,
      count: stores.length,
      stores: stores,
    });

  } catch (error) {
    console.error('Erro ao consultar a nova Google Places API:', error.response?.data || error.message);
    return res.status(500).json({ 
      message: 'Erro interno ao buscar lojas no Google Maps.', 
      error: error.response?.data || error.message 
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
      status: 'approved'
    });

    return res.status(201).json({
      success: true,
      message: 'Loja reivindicada com sucesso! Agora és o gestor oficial.'
    });

  } catch (error) {
    console.error('Erro ao reivindicar loja:', error);
    return res.status(500).json({ message: 'Erro interno ao reivindicar loja.', error: error.message });
  }
};