const db = require('../config/data_base');

class User {
  // Criar uma nova conta de utilizador (Jogador ou Loja) com tratamento para valores opcionais/nulos
  static async create({ name, email, password, account_type = 'PLAYER', latitude, longitude }) {
    const sql = `
      INSERT INTO users (name, email, password, account_type, latitude, longitude)
      VALUES (?, ?, ?, ?, ?, ?)
    `;
    
    // Garante que se latitude ou longitude forem undefined, o JavaScript envia explicitamente null
    const [result] = await db.execute(sql, [
      name, 
      email, 
      password, 
      account_type, 
      latitude ?? null, 
      longitude ?? null
    ]);
    
    return result.insertId;
  }

  // Listar todos os utilizadores (útil para testes da API)
  static async findAll() {
    const [rows] = await db.execute('SELECT id, name, email, account_type, created_at FROM users');
    return rows;
  }

  // Buscar utilizador por Email (Autenticação / Login)
  static async findByEmail(email) {
    const sql = `SELECT * FROM users WHERE email = ?`;
    const [rows] = await db.execute(sql, [email]);
    return rows[0];
  }

  // Buscar utilizador por ID
  static async findById(id) {
    const sql = `
      SELECT id, name, email, account_type, latitude, longitude, visibility_radius_km, is_visible, created_at 
      FROM users 
      WHERE id = ?
    `;
    const [rows] = await db.execute(sql, [id]);
    return rows[0];
  }

  // Atualizar coordenadas GPS e estado no mapa
  static async updateLocation(id, latitude, longitude, is_visible = 1) {
    const sql = `
      UPDATE users 
      SET latitude = ?, longitude = ?, is_visible = ? 
      WHERE id = ?
    `;
    const [result] = await db.execute(sql, [latitude ?? null, longitude ?? null, is_visible, id]);
    return result.affectedRows > 0;
  }
}

module.exports = User;