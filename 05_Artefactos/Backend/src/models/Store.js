const db = require('../config/data_base');

class Store {
  // Criar dados comerciais da loja associados ao user_id (com suporte a store_map_id e status)
  static async create({ user_id, store_map_id = null, store_name, address, phone, opening_hours, status = 'pending' }) {
    const sql = `
      INSERT INTO stores (user_id, store_map_id, store_name, address, phone, opening_hours, status)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `;
    const [result] = await db.execute(sql, [
      user_id, 
      store_map_id, 
      store_name, 
      address, 
      phone ?? null, 
      opening_hours ?? null, 
      status
    ]);
    return result.insertId;
  }

  // Buscar loja pelo ID do utilizador (incluindo dados do utilizador e estado da loja)
  static async findByUserId(user_id) {
    const sql = `
      SELECT s.*, u.name as owner_name, u.email, u.latitude, u.longitude 
      FROM stores s
      JOIN users u ON s.user_id = u.id
      WHERE s.user_id = ?
    `;
    const [rows] = await db.execute(sql, [user_id]);
    return rows[0];
  }

  // Listar todas as lojas parceiras com as respetivas coordenadas geográficas
  static async findAll() {
    const sql = `
      SELECT s.*, u.name as owner_name, u.email, u.latitude, u.longitude 
      FROM stores s
      JOIN users u ON s.user_id = u.id
    `;
    const [rows] = await db.execute(sql);
    return rows;
  }
}

module.exports = Store;