const Tournament = require('../models/Tournament');

exports.createTournament = async (req, res) => {
  try {
    const {
      organizer_id,
      type_id = 2, // Por defeito 2 = CASUAL para jogadores
      game_id,
      title,
      description,
      location_name,
      latitude,
      longitude,
      start_time,
      max_slots,
      entry_fee,
      is_private
    } = req.body;

    // Validações básicas
    if (!organizer_id || !game_id || !title || !start_time) {
      return res.status(400).json({ 
        message: 'Organizador, jogo, título e data de início são obrigatórios.' 
      });
    }

    // Criar o torneio através do Model
    const result = await Tournament.create({
      organizer_id,
      type_id,
      game_id,
      title,
      description,
      location_name,
      latitude,
      longitude,
      start_time,
      max_slots,
      entry_fee,
      is_private
    });

    return res.status(201).json({
      success: true,
      message: 'Torneio criado com sucesso!',
      tournamentId: result.tournamentId,
      invite_token: result.invite_token // Útil se for privado para partilhar com os amigos
    });

  } catch (error) {
    console.error('Erro ao criar torneio:', error);
    return res.status(500).json({ 
      message: 'Erro interno ao criar torneio.', 
      error: error.message 
    });
  }
};

// Listar todos os torneios
exports.getAllTournaments = async (req, res) => {
  try {
    const tournaments = await Tournament.findAll();
    return res.status(200).json({ success: true, count: tournaments.length, tournaments });
  } catch (error) {
    return res.status(500).json({ message: 'Erro ao buscar todos os torneios.' });
  }
};

// Listar apenas públicos
exports.getPublicTournaments = async (req, res) => {
  try {
    const tournaments = await Tournament.findAllPublic();
    return res.status(200).json({ success: true, count: tournaments.length, tournaments });
  } catch (error) {
    return res.status(500).json({ message: 'Erro ao buscar torneios públicos.' });
  }
};

// Listar apenas privados
exports.getPrivateTournaments = async (req, res) => {
  try {
    const tournaments = await Tournament.findAllPrivate();
    return res.status(200).json({ success: true, count: tournaments.length, tournaments });
  } catch (error) {
    return res.status(500).json({ message: 'Erro ao buscar torneios privados.' });
  }
};

// 🛠️ Atualizar torneio por ID
exports.updateTournament = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, description, location_name } = req.body;

    const success = await Tournament.update(id, { title, description, location_name });

    if (!success) {
      return res.status(404).json({ success: false, message: 'Torneio não encontrado para atualizar.' });
    }

    return res.status(200).json({ success: true, message: 'Torneio atualizado com sucesso!' });
  } catch (error) {
    console.error('Erro ao atualizar torneio:', error);
    return res.status(500).json({ success: false, message: 'Erro interno ao atualizar torneio.', error: error.message });
  }
};

// 🗑️ Apagar torneio por ID
exports.deleteTournament = async (req, res) => {
  try {
    const { id } = req.params;

    const success = await Tournament.delete(id);

    if (!success) {
      return res.status(404).json({ success: false, message: 'Torneio não encontrado para apagar.' });
    }

    return res.status(200).json({ success: true, message: 'Torneio apagado com sucesso!' });
  } catch (error) {
    console.error('Erro ao apagar torneio:', error);
    return res.status(500).json({ success: false, message: 'Erro interno ao apagar torneio.', error: error.message });
  }
};

// 🤝 Juntar-se a um torneio
exports.joinTournament = async (req, res) => {
  try {
    const { id } = req.params; // tournament ID
    const { user_id } = req.body;

    if (!user_id) {
      return res.status(400).json({ success: false, message: 'ID do utilizador é obrigatório.' });
    }

    const success = await Tournament.join(id, user_id);

    if (!success) {
      return res.status(400).json({ success: false, message: 'Não foi possível juntar-se ao torneio (já inscrito ou lotado).' });
    }

    return res.status(200).json({ success: true, message: 'Inscrição efetuada com sucesso!' });
  } catch (error) {
    console.error('Erro ao juntar-se ao torneio:', error);
    return res.status(500).json({ success: false, message: 'Erro interno ao processar inscrição.', error: error.message });
  }
};