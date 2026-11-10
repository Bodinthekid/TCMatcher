const User = require('../models/User');
const db = require('../config/data_base');

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
      store_name, 
      address, 
      phone, 
      opening_hours 
    } = req.body;

    // 1. Validação básica antes de tocar na base de dados
    const finalName = name || store_name;
    if (!finalName || !email || !password) {
      return res.status(400).json({ message: 'Nome, email e password são obrigatórios.' });
    }

    if (account_type === 'STORE' && (!store_name || !address)) {
      return res.status(400).json({ 
        message: 'Os campos nome da loja e morada são obrigatórios para contas do tipo STORE.' 
      });
    }

    // 2. Verificar se o email já existe
    const existingUser = await User.findByEmail(email);
    if (existingUser) {
      return res.status(409).json({ message: 'Este email já está registado.' });
    }

    // 3. Criar o utilizador base na tabela 'users'
    const userId = await User.create({ 
      name: finalName, 
      email, 
      password, 
      account_type, 
      latitude: latitude ?? null, 
      longitude: longitude ?? null 
    });

    // 4. Criar registo na subclasse correspondente (STORE ou PLAYER)
    if (account_type === 'STORE') {
      const storeSql = `
        INSERT INTO stores (user_id, store_name, address, phone, opening_hours)
        VALUES (?, ?, ?, ?, ?)
      `;
      await db.execute(storeSql, [
        userId, 
        store_name, 
        address, 
        phone ?? null, 
        opening_hours ?? null
      ]);
    } else if (account_type === 'PLAYER') {
      const playerSql = `
        INSERT INTO player_profiles (user_id)
        VALUES (?)
      `;
      await db.execute(playerSql, [userId]);
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

// Efetuar Login de Utilizador
exports.loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: 'Email e password são obrigatórios.' });
    }

    const user = await User.findByEmail(email);
    if (!user || user.password !== password) {
      return res.status(401).json({ message: 'Email ou palavra-passe incorretos.' });
    }

    return res.status(200).json({
      message: 'Login efetuado com sucesso!',
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        account_type: user.account_type
      }
    });

  } catch (error) {
    console.error('Erro ao efetuar login:', error);
    return res.status(500).json({ message: 'Erro interno ao efetuar login.', error: error.message });
  }
};