USE tcmatcher_db;

-- 1. Desativar restrições temporariamente para limpar sem erros
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Limpar dados antigos e reiniciar os IDs do Auto_Increment
TRUNCATE TABLE stores;
TRUNCATE TABLE users;

-- 3. Reativar restrições
SET FOREIGN_KEY_CHECKS = 1;

-- 4. Inserir Utilizadores base (Jogadores de 1 a 6 | Lojas 7 a 9)
INSERT INTO users (id, name, email, password, account_type, latitude, longitude) VALUES
-- Jogadores (PLAYER)
(1, 'João Silva', 'joao.silva@email.com', 'password123', 'PLAYER', 41.1579, -8.6291),
(2, 'Maria Santos', 'maria.santos@email.com', 'password123', 'PLAYER', 41.1520, -8.6100),
(3, 'Carlos Ferreira', 'carlos.ferreira@email.com', 'password123', 'PLAYER', 38.7223, -9.1393),
(4, 'Ana Rodrigues', 'ana.rodrigues@email.com', 'password123', 'PLAYER', 38.7169, -9.1399),
(5, 'Diogo Costa', 'diogo.costa@email.com', 'password123', 'PLAYER', 40.2033, -8.4103),
(6, 'Beatriz Lima', 'beatriz.lima@email.com', 'password123', 'PLAYER', 41.1496, -8.6109),

-- Lojas (STORE)
(7, 'Arena TCG Porto', 'contacto@arenatcg.pt', 'password123', 'STORE', 41.1496, -8.6110),
(8, 'Magic Center Lisboa', 'suporte@magiccenter.pt', 'password123', 'STORE', 38.7100, -9.1400),
(9, 'Coimbra Card Haven', 'geral@coimbracards.pt', 'password123', 'STORE', 40.2110, -8.4290);

-- 5. Inserir os dados comerciais associados diretamente por ID
INSERT INTO stores (user_id, store_name, address, phone, opening_hours) VALUES
(7, 'Arena TCG Porto', 'Rua de Camões, 123, Porto', '+351 220 000 000', '10:00 - 19:00'),
(8, 'Magic Center Lisboa', 'Avenida da Liberdade, 100, Lisboa', '+351 210 111 222', '09:30 - 20:00'),
(9, 'Coimbra Card Haven', 'Praça da República, 45, Coimbra', '+351 239 333 444', '10:00 - 18:30');