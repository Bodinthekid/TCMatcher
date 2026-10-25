// Carrega as variáveis do ficheiro .env
require('dotenv').config();

const mysql = require('mysql2/promise');

async function testDatabaseConnection() {
    let connection;

    try {
        // Estabelece a ligação à base de dados
        connection = await mysql.createConnection({
            host: process.env.DB_HOST,
            port: Number(process.env.DB_PORT),
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME
        });

        console.log('Ligação ao MySQL estabelecida com sucesso!');

        // Executa uma consulta para confirmar a ligação
        const [rows] = await connection.query(`
            SELECT
                DATABASE() AS database_name,
                VERSION() AS mysql_version
        `);

        console.log('Base de dados:', rows[0].database_name);
        console.log('Versão do MySQL:', rows[0].mysql_version);

        // Verifica quantas tabelas existem na base de dados
        const [tables] = await connection.query(`
            SELECT COUNT(*) AS total_tables
            FROM information_schema.tables
            WHERE table_schema = DATABASE()
              AND table_type = 'BASE TABLE'
        `);

        console.log('Total de tabelas:', tables[0].total_tables);

    } catch (error) {
        console.error('Erro na ligação à base de dados:');
        console.error(error.message);

    } finally {
        if (connection) {
            await connection.end();
            console.log('Ligação ao MySQL encerrada.');
        }
    }
}

testDatabaseConnection();