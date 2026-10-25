const User = require('../models/User');
const db = require('../config/data_base'); // para transações ou inserções adicionais

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

// Registar um novo utilizador (PLAYER ou STORE)
exports.registerUser = async (req, res) => {
  try {
    const { 
      name, 
      email, 
      password, 
      account_type = 'PLAYER', 
      latitude, 
      longitude,
      // Dados adicionais caso seja Loja:
      store_name, 
      address, 
      phone, 
      opening_hours 
    } = req.body;

    // 1. Validação básica
    if (!name || !email || !password) {
      return res.status(400).json({ message: 'Nome, email e password são obrigatórios.' });
    }

    // 2. Verificar se o email já existe
    const existingUser = await User.findByEmail(email);
    if (existingUser) {
      return res.status(409).json({ message: 'Este email já está registado.' });
    }

    // 3. Criar o utilizador base na tabela 'users'
    const userId = await User.create({ 
      name, 
      email, 
      password, 
      account_type, 
      latitude, 
      longitude 
    });

    // 4. Se o tipo de conta for STORE, criar também o registo na tabela 'stores'
    if (account_type === 'STORE') {
      if (!store_name || !address) {
        return res.status(400).json({ 
          message: 'Utilizador criado, mas os campos store_name e address são obrigatórios para contas do tipo STORE.' 
        });
      }

      const storeSql = `
        INSERT INTO stores (user_id, store_name, address, phone, opening_hours)
        VALUES (?, ?, ?, ?, ?)
      `;
      await db.execute(storeSql, [userId, store_name, address, phone, opening_hours]);
    }

    return res.status(201).json({ 
      message: `Conta de ${account_type} registada com sucesso!`, 
      userId 
    });

  } catch (error) {
    console.error('Erro ao registar utilizador:', error);
    return res.status(500).json({ message: 'Erro interno ao registar utilizador.', error: error.message });
  }
};