const express = require('express');
const cors = require('cors');
require('dotenv').config();

// Inicializar a aplicação Express
const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares essenciais
app.use(express.json()); // Permite receber dados em formato JSON no body das requisições
app.use(cors());         // Permite requisições do frontend (Flutter)

// Importar existentes
const userRoutes = require('./src/routes/userRoutes');
const storeRoutes = require('./src/routes/storeRoutes'); // <-- Adicionar aqui

// Registar rotas na aplicação
app.use('/api/users', userRoutes);
app.use('/api/stores', storeRoutes); // <-- Adicionar aqui

// Rota de teste básica para verificar se o servidor está vivo
app.get('/', (req, res) => {
    res.json({ message: 'API do TCMatcher a funcionar com sucesso! 🚀' });
});

// Arrancar o servidor na porta definida no .env ou 3000 por defeito
app.listen(PORT, () =>  {
    console.log(`Servidor a correr na porta ${PORT}`);
});