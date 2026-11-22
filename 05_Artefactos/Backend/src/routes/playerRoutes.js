const express = require('express');
const rateLimit = require('express-rate-limit');
const auth = require('../middleware/auth');
const playerController = require('../controllers/playerController');

const router = express.Router();

// Limita o número de pedidos por minuto para evitar abuso/sondagens
const playersLimiter = rateLimit({
  windowMs: 60 * 1000,
  max: 60,
  standardHeaders: true,
  legacyHeaders: false,
  message: { message: 'Demasiados pedidos. Tenta novamente dentro de instantes.' },
});

router.use(auth, playersLimiter);

// Atualiza (ou cria) a localização aproximada do utilizador autenticado
router.put('/me/location', playerController.updateMyLocation);

// Remove imediatamente a localização quando o utilizador desativa a partilha
router.delete('/me/location', playerController.stopSharing);

// Lista jogadores disponíveis por perto (exige que o próprio também esteja ativo)
router.get('/nearby', playerController.getNearbyPlayers);

module.exports = router;