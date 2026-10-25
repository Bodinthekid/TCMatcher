const db = require('../config/data_base');

class User {
  // Criar um novo utilizador na base de dados
  static async create({ name, email, password, account_type = 'PLAYER', latitude, longitude }) {
    const sql = `
      INSERT INTO users (name, email, password, account_type, latitude, longitude)
      VALUES (?, ?, ?, ?, ?, ?)
    `;
    const [result] = await db.execute(sql, [name, email, password, account_type, latitude, longitude]);
    return result.insertId;
  }

  // Buscar todos os utilizadores (útil para testes da API)
  static async findAll() {
    const [rows] = await db.execute('SELECT id, name, email, account_type, created_at FROM users');
    return rows;
  }

  // Buscar utilizador por Email
  static async findByEmail(email) {
    const sql = `SELECT * FROM users WHERE email = ?`;
    const [rows] = await db.execute(sql, [email]);
    return rows[0];
  }
}

module.exports = User;