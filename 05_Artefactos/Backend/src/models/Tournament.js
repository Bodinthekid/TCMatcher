const db = require('../config/data_base');
const crypto = require('crypto');

class Tournament {
  // Criar um torneio (Casual ou Oficial)
  static async create({
    organizer_id,
    type_id, // 1 = OFFICIAL, 2 = CASUAL
    game_id,
    title,
    description,
    location_name,
    latitude,
    longitude,
    start_time,
    max_slots = 16,
    entry_fee = 0.00,
    is_private = 0
  }) {
    // Se for privado, geramos um token único para o link de convite
    const invite_token = is_private ? crypto.randomBytes(16).toString('hex') : null;

    const sql = `
      INSERT INTO tournaments 
      (organizer_id, type_id, game_id, title, description, location_name, latitude, longitude, start_time, max_slots, entry_fee, is_private, invite_token)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const [result] = await db.execute(sql, [
      organizer_id,
      type_id,
      game_id,
      title,
      description ?? null,
      location_name ?? null,
      latitude ?? null,
      longitude ?? null,
      start_time,
      max_slots,
      entry_fee,
      is_private,
      invite_token
    ]);

    return { tournamentId: result.insertId, invite_token };
  }

  // Listar torneios públicos próximos ou gerais
  static async findAllPublic() {
    const sql = `
      SELECT t.*, u.name as organizer_name, tg.name as game_name, tt.code as type_code
      FROM tournaments t
      JOIN users u ON t.organizer_id = u.id
      JOIN tcg_games tg ON t.game_id = tg.id
      JOIN tournament_types tt ON t.type_id = tt.id
      WHERE t.is_private = 0
      ORDER BY t.start_time ASC
    `;
    const [rows] = await db.execute(sql);
    return rows;
  }

  // Buscar todos os torneios (públicos e privados)
  static async findAll() {
    const sql = `
      SELECT t.*, u.name as organizer_name, tg.name as game_name, tt.code as type_code
      FROM tournaments t
      JOIN users u ON t.organizer_id = u.id
      JOIN tcg_games tg ON t.game_id = tg.id
      JOIN tournament_types tt ON t.type_id = tt.id
      ORDER BY t.start_time ASC
    `;
    const [rows] = await db.execute(sql);
    return rows;
  }

  // Listar torneios privados
  static async findAllPrivate() {
    const sql = `
      SELECT t.*, u.name as organizer_name, tg.name as game_name, tt.code as type_code
      FROM tournaments t
      JOIN users u ON t.organizer_id = u.id
      JOIN tcg_games tg ON t.game_id = tg.id
      JOIN tournament_types tt ON t.type_id = tt.id
      WHERE t.is_private = 1
      ORDER BY t.start_time ASC
    `;
    const [rows] = await db.execute(sql);
    return rows;
  }

  // 🛠️ Atualizar dados de um torneio existente
  static async update(id, { title, description, location_name }) {
    const sql = `
      UPDATE tournaments 
      SET title = ?, description = ?, location_name = ?
      WHERE id = ?
    `;
    const [result] = await db.execute(sql, [
      title,
      description ?? null,
      location_name ?? null,
      id
    ]);
    return result.affectedRows > 0;
  }

  // 🗑️ Apagar um torneio por ID
  static async delete(id) {
    const sql = `DELETE FROM tournaments WHERE id = ?`;
    const [result] = await db.execute(sql, [id]);
    return result.affectedRows > 0;
  }

  // 🤝 Juntar-se a um torneio (Inscrever um utilizador)
  static async join(tournamentId, userId) {
    // Exemplo básico: insere na tabela de participantes (ajusta o nome da tabela se diferir na tua BD)
    const sql = `
      INSERT IGNORE INTO tournament_participants (tournament_id, user_id)
      VALUES (?, ?)
    `;
    const [result] = await db.execute(sql, [tournamentId, userId]);
    return result.affectedRows > 0;
  }
}

module.exports = Tournament;