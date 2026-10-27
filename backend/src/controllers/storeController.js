const Store = require('../models/Store');

// Listar todas as lojas
exports.getAllStores = async (req, res) => {
  try {
    const stores = await Store.findAll();
    return res.status(200).json(stores);
  } catch (error) {
    console.error('Erro ao listar lojas:', error);
    return res.status(500).json({ message: 'Erro interno ao buscar lojas.', error: error.message });
  }
};

// Obter loja por ID do utilizador
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