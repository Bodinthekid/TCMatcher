const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
  const authHeader = req.headers.authorization || '';
  const token = authHeader.startsWith('Bearer ')
    ? authHeader.slice(7).trim()
    : null;

  if (!token) {
    return res.status(401).json({
      message: 'Não autenticado. Token em falta.',
    });
  }

  if (!process.env.JWT_SECRET) {
    console.error('JWT_SECRET não definido no .env');
    return res.status(500).json({
      message: 'Erro interno de configuração de autenticação.',
    });
  }

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET);
    req.user = { id: payload.id };
    return next();
  } catch (error) {
    return res.status(401).json({
      message: 'Sessão inválida ou expirada.',
    });
  }
};