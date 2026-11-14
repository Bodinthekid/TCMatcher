const db = require('../config/data_base'); // Ajusta o caminho da tua conexão MySQL se necessário
const Store = require('../models/Store');

// Listar todas as lojas parceiras (da tabela stores)
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

// 🌍 Pesquisar lojas no mapa por proximidade (Lê do stores_map + indica se está verificada)
exports.getNearbyStores = async (req, res) => {
  try {
    const { lat, lon, radius = 5000 } = req.query;

    if (!lat || !lon) {
      return res.status(400).json({ message: 'Latitude e longitude são obrigatórias.' });
    }

    const targetLat = parseFloat(lat);
    const targetLon = parseFloat(lon);
    const maxRadiusMeters = parseFloat(radius);

    // 1. Buscar todas as lojas do mapa global (pre-chegadas pelo script do Overpass)
    // Fazemos LEFT JOIN com a tabela stores para verificar se já tem dono atribuído
    const [mapStores] = await db.execute(`
      SELECT 
        m.id, m.country, m.name, m.city, m.address, m.postal_code, 
        m.phone, m.website, m.opening_hours, m.lat, m.lon,
        CASE WHEN s.id IS NOT NULL THEN TRUE ELSE FALSE END AS is_verified,
        s.id AS partner_store_id,
        s.user_id
      FROM stores_map m
      LEFT JOIN stores s ON m.id = s.store_map_id
    `);

    // 2. Função auxiliar para calcular a distância em metros (Fórmula de Haversine)
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

    // 3. Filtrar as lojas do mapa que estão dentro do raio pretendido
    const nearbyStores = mapStores.filter(store => {
      const dist = calculateDistance(targetLat, targetLon, store.lat, store.lon);
      return dist <= maxRadiusMeters;
    });

    return res.status(200).json({
      success: true,
      count: nearbyStores.length,
      stores: nearbyStores
    });

  } catch (error) {
    console.error('Erro ao buscar lojas próximas do mapa:', error);
    return res.status(500).json({ 
      message: 'Erro interno ao buscar lojas próximas.', 
      error: error.message 
    });
  }
};

// 🔐 Reivindicar uma loja do mapa (converte uma loja do OSM numa loja parceira verificada)
exports.claimStore = async (req, res) => {
  try {
    const { userId, storeMapId, phone, openingHours } = req.body;

    if (!userId || !storeMapId) {
      return res.status(400).json({ message: 'User ID e Store Map ID são obrigatórios.' });
    }

    // 1. Verificar se a loja existe no stores_map
    const [mapStore] = await db.execute('SELECT * FROM stores_map WHERE id = ?', [storeMapId]);
    if (mapStore.length === 0) {
      return res.status(404).json({ message: 'Loja não encontrada no mapa global.' });
    }

    // 2. Verificar se esta loja já foi reivindicada por outro utilizador
    const [existingClaim] = await db.execute('SELECT * FROM stores WHERE store_map_id = ?', [storeMapId]);
    if (existingClaim.length > 0) {
      return res.status(400).json({ message: 'Esta loja já foi reivindicada por outro utilizador.' });
    }

    // 3. Inserir o registo na tabela stores oficial usando o Model Store
    const data = mapStore[0];
    await Store.create({
      user_id: userId,
      store_map_id: storeMapId,
      store_name: data.name,
      address: data.address || 'Morada não especificada',
      phone: phone || data.phone,
      opening_hours: openingHours || data.opening_hours,
      status: 'approved' // ou 'pending', conforme a tua regra de negócio para lojas reivindicadas
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

// 🌍 Obter todas as lojas de um país específico (ex: Portugal) do stores_map
exports.getStoresByCountry = async (req, res) => {
  try {
    const { country = 'Portugal' } = req.query;

    const [rows] = await db.execute(`
      SELECT 
        m.id, m.country, m.name, m.city, m.address, m.postal_code, 
        m.phone, m.website, m.opening_hours, m.lat, m.lon,
        CASE WHEN s.id IS NOT NULL THEN TRUE ELSE FALSE END AS is_verified,
        s.id AS partner_store_id,
        s.user_id
      FROM stores_map m
      LEFT JOIN stores s ON m.id = s.store_map_id
      WHERE m.country = ?
    `, [country]);

    return res.status(200).json({
      success: true,
      count: rows.length,
      stores: rows
    });

  } catch (error) {
    console.error('Erro ao buscar lojas por país:', error);
    return res.status(500).json({ 
      message: 'Erro interno ao buscar lojas do país.', 
      error: error.message 
    });
  }
};