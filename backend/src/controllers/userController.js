const User = require('../models/User');

// Listar todos os utilizadores
exports.getUsers = async (req, res) => {
  try {
    const users = await User.findAll();
    return res.status(200).json(users);
  } catch (error) {
    console.error('Erro ao listar utilizadores:', error);
    return res.status(500).json({ message: 'Erro interno no servidor.', error: error.message });
  }
};

// Registar um novo utilizador
exports.registerUser = async (req, res) => {
  try {
    const { name, email, password, account_type, latitude, longitude } = req.body;

    // Validação básica dos campos obrigatórios
    if (!name || !email || !password) {
      return res.status(400).json({ message: 'Nome, email e password são obrigatórios.' });
    }

    // Verificar se o email já existe
    const existingUser = await User.findByEmail(email);
    if (existingUser) {
      return res.status(409).json({ message: 'Este email já está registado.' });
    }

    // Criar o utilizador
    const userId = await User.create({ name, email, password, account_type, latitude, longitude });
    
    return res.status(201).json({ 
      message: 'Utilizador registado com sucesso!', 
      userId 
    });
  } catch (error) {
    console.error('Erro ao registar utilizador:', error);
    return res.status(500).json({ message: 'Erro interno ao registar utilizador.', error: error.message });
  }
};