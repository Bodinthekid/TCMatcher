-- ============================================================================
-- PROJETO: TCMatcher - Modelo Entidade-Relação (ERM-II)
-- UC: Bases de Dados - Prof. Miguel Boavida
-- BASE DE DADOS: tcmatcher_db
-- MOTOR DE ARMAZENAMENTO: InnoDB (Suporte para transações e Foreign Keys)
-- CODIFICAÇÃO: UTF-8 (utf8mb4) para suporte a múltiplos carateres e emojis
-- ============================================================================

-- TODO NAO USAR O ENUM usar as tabelas simles

-- Criar a base de dados do projeto se ainda não existir
CREATE DATABASE IF NOT EXISTS tcmatcher_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Selecionar a base de dados tcmatcher_db para a criação das tabelas
USE tcmatcher_db;

-- ----------------------------------------------------------------------------
-- 1. ENTIDADE BASE / SUPERCLASSE: users
-- DESCRIÇÃO: Tabela principal de contas. Armazena credenciais e localização.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    account_type ENUM('PLAYER', 'STORE', 'ADMIN') NOT NULL DEFAULT 'PLAYER',
    latitude DECIMAL(10, 8) NULL,
    longitude DECIMAL(11, 8) NULL,
    visibility_radius_km DECIMAL(5, 2) DEFAULT 5.00,
    is_visible TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. ENTIDADE PROMOVIDA: tcg_games
-- DESCRIÇÃO: Catálogo central dos jogos de cartas (TCGs) suportados pela app.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tcg_games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. SUBCLASSE / ESPECIALIZAÇÃO 1: player_profiles
-- DESCRIÇÃO: Extensão 1:1 da tabela users contendo dados específicos do jogador.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS player_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    experience_level ENUM('BEGINNER', 'CASUAL', 'COMPETITIVE') DEFAULT 'CASUAL',
    bio TEXT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 4. TABELA DE LIGAÇÃO (DECOMPOSIÇÃO N:M): player_games
-- DESCRIÇÃO: Associa quais TCGs cada jogador pratica ou tem interesse.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS player_games (
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    PRIMARY KEY (user_id, game_id),
    FOREIGN KEY (user_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (game_id) REFERENCES tcg_games(id) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 5. ENTIDADE DO MAPA (OSM): stores_map
-- DESCRIÇÃO: Guarda os dados geográficos globais importados da API Overpass.
-- (Colocada aqui antes de 'stores' para respeitar a dependência da Chave Estrangeira)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS stores_map (
    id VARCHAR(100) PRIMARY KEY,             -- Ex: "node/12345678" ou "way/87654321"
    country VARCHAR(50) NOT NULL,            -- Ex: "Portugal", "Spain"
    element_type VARCHAR(20),                -- Ex: "node", "way", "relation"
    name VARCHAR(255) NOT NULL,              -- Store name
    city VARCHAR(100),                       -- City / Locality
    address VARCHAR(255),                    -- Street and house number combined
    postal_code VARCHAR(20),                 -- Postal code / Zip code
    phone VARCHAR(50),                       -- Contact phone number
    website VARCHAR(255),                    -- Official website URL
    opening_hours VARCHAR(255),              -- Business hours / Schedule
    lat DECIMAL(10, 8) NOT NULL,             -- Latitude coordinate
    lon DECIMAL(11, 8) NOT NULL              -- Longitude coordinate
) ENGINE=InnoDB;

-- Índice para otimizar pesquisas por país no mapa
CREATE INDEX idx_stores_country ON stores_map(country);

-- ----------------------------------------------------------------------------
-- 6. SUBCLASSE / ESPECIALIZAÇÃO 2: stores
-- DESCRIÇÃO: Extensão 1:1 da tabela users para contas do tipo STORE, 
--            ligada opcionalmente ao mapa global através de 'store_map_id'.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS stores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    store_map_id VARCHAR(100) NULL,
    store_name VARCHAR(150) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NULL,
    opening_hours VARCHAR(100) NULL,
    status VARCHAR(50) DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (store_map_id) REFERENCES stores_map(id) 
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Índice para acelerar a busca de lojas parceiras associadas ao mapa
CREATE INDEX idx_stores_map_id ON stores(store_map_id);

-- ----------------------------------------------------------------------------
-- 7. ENTIDADE: tournaments
-- DESCRIÇÃO: Regista os torneios e eventos organizados pelas lojas.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tournaments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    game_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NULL,
    max_slots INT DEFAULT 16,
    entry_fee DECIMAL(8, 2) DEFAULT 0.00,
    FOREIGN KEY (store_id) REFERENCES stores(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (game_id) REFERENCES tcg_games(id) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 8. TABELA DE LIGAÇÃO (DECOMPOSIÇÃO N:M): tournament_registrations
-- DESCRIÇÃO: Controla inscritos e o check-in presencial no evento.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tournament_registrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tournament_id INT NOT NULL,
    user_id INT NOT NULL,
    registered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_checked_in TINYINT(1) DEFAULT 0,
    CONSTRAINT uq_tournament_user UNIQUE (tournament_id, user_id),
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 9. AUTO-RELACIONAMENTO (SELF-RELATIONSHIP): matches
-- DESCRIÇÃO: Guarda o registo das partidas disputadas entre dois jogadores.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player1_id INT NOT NULL,
    player2_id INT NOT NULL,
    game_id INT NOT NULL,
    winner_id INT NULL,
    is_confirmed TINYINT(1) DEFAULT 0,
    played_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_different_players CHECK (player1_id <> player2_id),
    FOREIGN KEY (player1_id) REFERENCES users(id),
    FOREIGN KEY (player2_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES tcg_games(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (winner_id) REFERENCES users(id) 
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 10. AUTO-RELACIONAMENTO (SELF-RELATIONSHIP): chat_messages
-- DESCRIÇÃO: Regista as mensagens trocadas no chat direto entre utilizadores.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS chat_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_read TINYINT(1) DEFAULT 0,
    FOREIGN KEY (sender_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;