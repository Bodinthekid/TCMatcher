-- ============================================================================
-- PROJETO: TCMatcher - Modelo Entidade-Relação (ERM-II)
-- UC: Bases de Dados
-- BASE DE DADOS: tcmatcher_db
-- MOTOR DE ARMAZENAMENTO: InnoDB (Suporte para transações e Foreign Keys)
-- CODIFICAÇÃO: UTF-8 (utf8mb4) para suporte a múltiplos carateres e emojis
-- NOTA: sem ENUMs. Os valores fixos vivem em tabelas de referência (lookup)
--       com ids explícitos, iguais em todos os ambientes.
-- ============================================================================

CREATE DATABASE IF NOT EXISTS tcmatcher_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE tcmatcher_db;

-- ----------------------------------------------------------------------------
-- 0. TABELAS DE REFERÊNCIA (substituem os ENUMs)
-- ----------------------------------------------------------------------------

-- 0.1 Tipos de conta
CREATE TABLE IF NOT EXISTS account_types (
    id TINYINT UNSIGNED PRIMARY KEY,
    code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

INSERT IGNORE INTO account_types (id, code, name) VALUES
    (1, 'PLAYER', 'Jogador'),
    (2, 'STORE',  'Loja'),
    (3, 'ADMIN',  'Administrador');

-- 0.2 Níveis de experiência
CREATE TABLE IF NOT EXISTS experience_levels (
    id TINYINT UNSIGNED PRIMARY KEY,
    code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

INSERT IGNORE INTO experience_levels (id, code, name) VALUES
    (1, 'BEGINNER',    'Iniciante'),
    (2, 'CASUAL',      'Casual'),
    (3, 'COMPETITIVE', 'Competitivo');

-- 0.3 Tipos de torneio (requires_store: só contas STORE podem criar este tipo)
CREATE TABLE IF NOT EXISTS tournament_types (
    id TINYINT UNSIGNED PRIMARY KEY,
    code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    requires_store TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB;

INSERT IGNORE INTO tournament_types (id, code, name, requires_store) VALUES
    (1, 'OFFICIAL', 'Torneio Oficial', 1),
    (2, 'CASUAL',   'Torneio Casual',  0);

-- ----------------------------------------------------------------------------
-- 1. ENTIDADE BASE / SUPERCLASSE: users
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    account_type_id TINYINT UNSIGNED NOT NULL DEFAULT 1,  -- 1 = PLAYER
    latitude DECIMAL(10, 8) NULL,
    longitude DECIMAL(11, 8) NULL,
    visibility_radius_km DECIMAL(5, 2) DEFAULT 5.00,
    is_visible TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_type_id) REFERENCES account_types(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. ENTIDADE PROMOVIDA: tcg_games
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tcg_games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NULL
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. SUBCLASSE 1: player_profiles
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS player_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    experience_level_id TINYINT UNSIGNED NOT NULL DEFAULT 2,  -- 2 = CASUAL
    bio TEXT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (experience_level_id) REFERENCES experience_levels(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 4. LIGAÇÃO N:M: player_games
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
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS stores_map (
    id VARCHAR(100) PRIMARY KEY,             -- Ex: "node/12345678"
    country VARCHAR(50) NOT NULL,
    element_type VARCHAR(20),
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    address VARCHAR(255),
    postal_code VARCHAR(20),
    phone VARCHAR(50),
    website VARCHAR(255),
    opening_hours VARCHAR(255),
    lat DECIMAL(10, 8) NOT NULL,
    lon DECIMAL(11, 8) NOT NULL
) ENGINE=InnoDB;

CREATE INDEX idx_stores_country ON stores_map(country);

-- ----------------------------------------------------------------------------
-- 6. SUBCLASSE 2: stores
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

CREATE INDEX idx_stores_map_id ON stores(store_map_id);

-- ----------------------------------------------------------------------------
-- 7. ENTIDADE: tournaments
-- DESCRIÇÃO: Torneios oficiais (criados por lojas) e casuais (criados por
--            jogadores). O organizador é sempre um utilizador.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tournaments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    organizer_id INT NOT NULL,
    type_id TINYINT UNSIGNED NOT NULL,
    game_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NULL,
    location_name VARCHAR(150) NULL,         -- local do torneio (casuais)
    latitude DECIMAL(10, 8) NULL,
    longitude DECIMAL(11, 8) NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NULL,
    max_slots INT DEFAULT 16,
    entry_fee DECIMAL(8, 2) DEFAULT 0.00,
    FOREIGN KEY (organizer_id) REFERENCES users(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (type_id) REFERENCES tournament_types(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (game_id) REFERENCES tcg_games(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_tournaments_type ON tournaments(type_id);
CREATE INDEX idx_tournaments_start ON tournaments(start_time);

-- ----------------------------------------------------------------------------
-- 8. LIGAÇÃO N:M: tournament_registrations
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
-- 9. AUTO-RELACIONAMENTO: matches
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
-- 10. AUTO-RELACIONAMENTO: chat_messages
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