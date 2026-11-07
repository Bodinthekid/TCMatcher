const express = require('express');
const router = express.Router();
const storeController = require('../controllers/storeController');

// GET /api/stores - Lista todas as lojas
router.get('/', storeController.getAllStores);

// GET /api/stores/user/:userId - Busca os dados da loja de um utilizador específico
router.get('/user/:userId', storeController.getStoreByUserId);


module.exports = router;