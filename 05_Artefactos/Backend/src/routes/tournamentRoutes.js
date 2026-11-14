const express = require('express');
const router = express.Router();
const tournamentController = require('../controllers/tournamentController');

// Rota POST para criar um torneio (casual ou oficial)
router.post('/', tournamentController.createTournament);

// Rota GET para listar os torneios públicos disponíveis
router.get('/', tournamentController.getPublicTournaments);

// Rota PUT para atualizar um torneio existente por ID
router.put('/:id', tournamentController.updateTournament);

// Rota DELETE para apagar/cancelar um torneio por ID
router.delete('/:id', tournamentController.deleteTournament);

// Rota POST para juntar-se a um torneio (caso já tenhas implementado)
router.post('/:id/join', tournamentController.joinTournament);

module.exports = router;