const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Rota para listar todos os utilizadores (GET /api/users)
router.get('/', userController.getUsers);

// Rota para registar um novo utilizador (POST /api/users/register)
router.post('/register', userController.registerUser);

module.exports = router;