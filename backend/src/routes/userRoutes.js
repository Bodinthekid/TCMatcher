const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// GET Rota para listar todos os utilizadores (GET /api/users)
router.get('/', userController.getUsers);

// GET Rota para registar um novo utilizador (POST /api/users/register)
router.post('/register', userController.registerUser);

// POST endpoint para o login
router.post('/login', userController.loginUser);

module.exports = router;