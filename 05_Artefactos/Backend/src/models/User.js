const db = require('../config/data_base');

class User {
  // Criar uma nova conta de utilizador usando account_type_id (por defeito 1 = PLAYER)
  static async create({ name, email, password, account_type_id = 1, latitude, longitude }) {
    const sql = `
      INSERT INTO users (name, email, password, account_type_id, latitude, longitude)
      VALUES (?, ?, ?, ?, ?, ?)
    `;
    
    const [result] = await db.execute(sql, [
      name, 
      email, 
      password, 
      account_type_id, 
      latitude ?? null, 
      longitude ?? null
    ]);
    
    return result.insertId;
  }

  // Listar todos os utilizadores com JOIN para trazer o código legível do tipo de conta
  static async findAll() {
    const sql = `
      SELECT u.id, u.name, u.email, at.code as account_type, u.created_at 
      FROM users u
      JOIN account_types at ON u.account_type_id = at.id
    `;
    const [rows] = await db.execute(sql);
    return rows;
  }

  // Buscar utilizador por Email (Autenticação / Login) com JOIN
  static async findByEmail(email) {
    const sql = `
      SELECT u.*, at.code as account_type 
      FROM users u
      JOIN account_types at ON u.account_type_id = at.id
      WHERE u.email = ?
    `;
    const [rows] = await db.execute(sql, [email]);
    return rows[0];
  }

  // Buscar utilizador por ID com JOIN
  static async findById(id) {
    const sql = `
      SELECT u.id, u.name, u.email, at.code as account_type, 
             u.latitude, u.longitude, u.visibility_radius_km, u.is_visible, u.created_at 
      FROM users u
      JOIN account_types at ON u.account_type_id = at.id
      WHERE u.id = ?
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