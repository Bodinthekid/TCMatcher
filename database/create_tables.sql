-- ============================================================================
-- PROJETO: TCMatcher - Modelo Entidade-Relação (ERM-II)
-- UC: Bases de Dados - Prof. Miguel Boavida
-- BASE DE DADOS: tcmatcher_db
-- MOTOR DE ARMAZENAMENTO: InnoDB (Suporte para transações e Foreign Keys)
-- CODIFICAÇÃO: UTF-8 (utf8mb4) para suporte a múltiplos carateres e emojis
-- ============================================================================

-- Criar a base de dados do projeto se ainda não existir
CREATE DATABASE IF NOT EXISTS tcmatcher_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Selecionar a base de dados tcmatcher_db para a criação das tabelas
USE tcmatcher_db;

-- ----------------------------------------------------------------------------
-- 1. ENTIDADE BASE / SUPERCLASSE: users
-- CONCEITO ERM: Entidade Genérica / Herança (Supertype)
-- DESCRIÇÃO: Tabela principal de contas. Armazena credenciais e localização 
--            geográfica de todos os utilizadores (jogadores, lojas e admins).
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,                           -- Identificador único e chave primária do utilizador
    name VARCHAR(100) NOT NULL,                                  -- Nome completo do utilizador ou nome do responsável
    email VARCHAR(150) NOT NULL UNIQUE,                          -- Endereço de e-mail único para autenticação e contacto
    password VARCHAR(255) NOT NULL,                              -- Hash de segurança da palavra-passe de acesso
    account_type ENUM('PLAYER', 'STORE', 'ADMIN') NOT NULL DEFAULT 'PLAYER', -- Discriminador de Subtipo (perfil de acesso)
    latitude DECIMAL(10, 8) NULL,                                -- Coordenada de latitude geográfica para o mapa
    longitude DECIMAL(11, 8) NULL,                               -- Coordenada de longitude geográfica para o mapa
    visibility_radius_km DECIMAL(5, 2) DEFAULT 5.00,             -- Raio máximo em km definido pelo jogador para encontrar rivais
    is_visible TINYINT(1) DEFAULT 1,                             -- Indicador (1/0) de estado online/visível no mapa de jogo
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP                -- Carimbo de data/hora do registo do utilizador
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. ENTIDADE PROMOVIDA: tcg_games
-- CONCEITO ERM: Atributo Promovido a Entidade para Garantir Consistência
-- DESCRIÇÃO: Catálogo central dos jogos de cartas (TCGs) suportados pela app.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tcg_games (
    id INT AUTO_INCREMENT PRIMARY KEY,                           -- Identificador único e chave primária do jogo
    name VARCHAR(100) NOT NULL UNIQUE,                           -- Nome comercial do TCG (ex: 'Pokémon TCG', 'Magic')
    description TEXT NULL                                        -- Resumo descritivo ou regras gerais do jogo
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. SUBCLASSE / ESPECIALIZAÇÃO 1: player_profiles
-- CONCEITO ERM: Herança / Subtype (Especialização do 'users' do tipo PLAYER)
-- DESCRIÇÃO: Extensão 1:1 da tabela users contendo dados específicos do jogador.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS player_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,                           -- Identificador único da ficha de perfil
    user_id INT NOT NULL UNIQUE,                                 -- Chave estrangeira e relação 1:1 com a Superclasse users
    experience_level ENUM('BEGINNER', 'CASUAL', 'COMPETITIVE') DEFAULT 'CASUAL', -- Nível de habilidade do jogador
    bio TEXT NULL,                                              -- Biografia ou apresentação curta exibida no perfil público
    FOREIGN KEY (user_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Apaga/atualiza o perfil se o utilizador for removido/alterado
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 4. TABELA DE LIGAÇÃO (DECOMPOSIÇÃO N:M): player_games
-- CONCEITO ERM: Decomposição da Relação Muitos-para-Muitos (users <-> tcg_games)
-- DESCRIÇÃO: Associa quais TCGs cada jogador pratica ou tem interesse.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS player_games (
    user_id INT NOT NULL,                                        -- Chave estrangeira que referencia o jogador
    game_id INT NOT NULL,                                        -- Chave estrangeira que referencia o jogo TCG
    PRIMARY KEY (user_id, game_id),                             -- Chave primária composta para impedir registos duplicados
    FOREIGN KEY (user_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Elimina a associação caso o jogador seja apagado
    FOREIGN KEY (game_id) REFERENCES tcg_games(id) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Elimina a associação caso o TCG seja apagado
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 5. SUBCLASSE / ESPECIALIZAÇÃO 2: stores
-- CONCEITO ERM: Herança / Subtype (Especialização do 'users' do tipo STORE)
-- DESCRIÇÃO: Extensão 1:1 da tabela users para contas do tipo STORE.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS stores (
    id INT AUTO_INCREMENT PRIMARY KEY,                           -- Identificador único da loja física
    user_id INT NOT NULL UNIQUE,                                 -- Chave estrangeira e relação 1:1 com a Superclasse users
    store_name VARCHAR(150) NOT NULL,                            -- Nome comercial ou público do estabelecimento
    address VARCHAR(255) NOT NULL,                               -- Endereço físico completo da loja
    phone VARCHAR(20) NULL,                                      -- Número de contacto telefónico da loja
    opening_hours VARCHAR(100) NULL,                             -- Descrição dos horários e dias de abertura
    FOREIGN KEY (user_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Apaga a loja se a conta de utilizador for removida
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 6. ENTIDADE: tournaments
-- CONCEITO ERM: Relações 1:N entre 'stores' e 'tcg_games'
-- DESCRIÇÃO: Regista os torneios e eventos organizados pelas lojas.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tournaments (
    id INT AUTO_INCREMENT PRIMARY KEY,                           -- Identificador único e chave primária do evento/torneio
    store_id INT NOT NULL,                                       -- Chave estrangeira da loja organizadora
    game_id INT NOT NULL,                                        -- Chave estrangeira do TCG específico do evento
    title VARCHAR(150) NOT NULL,                                 -- Título público do torneio (ex: 'Friday Night Magic')
    description TEXT NULL,                                        -- Detalhes sobre o evento, prémios ou formato
    start_time DATETIME NOT NULL,                                -- Data e hora marcadas para o arranque do torneio
    end_time DATETIME NULL,                                      -- Data e hora previstas para o encerramento do evento
    max_slots INT DEFAULT 16,                                    -- Lotação máxima do número de participantes
    entry_fee DECIMAL(8, 2) DEFAULT 0.00,                        -- Custo do valor de entrada/taxa de inscrição em Euros
    FOREIGN KEY (store_id) REFERENCES stores(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Apaga os eventos se a loja for removida
    FOREIGN KEY (game_id) REFERENCES tcg_games(id) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Apaga os eventos se o TCG associado for removido
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 7. TABELA DE LIGAÇÃO (DECOMPOSIÇÃO N:M): tournament_registrations
-- CONCEITO ERM: Decomposição da Relação Muitos-para-Muitos (users <-> tournaments)
-- DESCRIÇÃO: Controla inscritos e o check-in presencial no evento.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tournament_registrations (
    id INT AUTO_INCREMENT PRIMARY KEY,                           -- Identificador único do comprovativo de inscrição
    tournament_id INT NOT NULL,                                  -- Chave estrangeira do evento/torneio
    user_id INT NOT NULL,                                        -- Chave estrangeira do jogador inscrito
    registered_at DATETIME DEFAULT CURRENT_TIMESTAMP,            -- Carimbo de data/hora em que a inscrição foi efetuada
    is_checked_in TINYINT(1) DEFAULT 0,                          -- Indicador (1/0) de validação de presença (check-in) na loja
    CONSTRAINT uq_tournament_user UNIQUE (tournament_id, user_id), -- Impede que um jogador se inscreva duas vezes no mesmo evento
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Elimina a inscrição se o evento for cancelado/apagado
    FOREIGN KEY (user_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Elimina a inscrição se o jogador apagar a conta
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 8. AUTO-RELACIONAMENTO (SELF-RELATIONSHIP): matches
-- CONCEITO ERM: Auto-Relacionamento N:M na própria Entidade 'users'
-- DESCRIÇÃO: Guarda o registo das partidas disputadas entre dois jogadores.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS matches (
    id INT AUTO_INCREMENT PRIMARY KEY,                           -- Identificador único do registo da partida
    player1_id INT NOT NULL,                                     -- Chave estrangeira do primeiro participante
    player2_id INT NOT NULL,                                     -- Chave estrangeira do segundo participante
    game_id INT NOT NULL,                                        -- Chave estrangeira do TCG disputado na partida
    winner_id INT NULL,                                          -- Chave estrangeira do jogador vencedor (NULL em caso de empate)
    is_confirmed TINYINT(1) DEFAULT 0,                           -- Validação cruzada (1/0) da submissão por parte do adversário
    played_at DATETIME DEFAULT CURRENT_TIMESTAMP,                -- Data e hora em que a partida foi efetuada/registada
    CONSTRAINT chk_different_players CHECK (player1_id <> player2_id), -- Garante que um jogador não joga contra si próprio
    FOREIGN KEY (player1_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Mantém integridade se o jogador 1 for removido
    FOREIGN KEY (player2_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Mantém integridade se o jogador 2 for removido
    FOREIGN KEY (game_id) REFERENCES tcg_games(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Mantém integridade se o TCG for removido
    FOREIGN KEY (winner_id) REFERENCES users(id) 
        ON DELETE SET NULL ON UPDATE CASCADE                     -- Mantém o histórico da partida mesmo se a conta do vencedor for apagada
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 9. AUTO-RELACIONAMENTO (SELF-RELATIONSHIP): chat_messages
-- CONCEITO ERM: Auto-Relacionamento 1:N / N:M na própria Entidade 'users'
-- DESCRIÇÃO: Regista as mensagens trocadas no chat direto entre utilizadores.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS chat_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,                           -- Identificador único e chave primária de cada mensagem
    sender_id INT NOT NULL,                                      -- Chave estrangeira do utilizador que enviou a mensagem
    receiver_id INT NOT NULL,                                    -- Chave estrangeira do utilizador que recebe a mensagem
    content TEXT NOT NULL,                                       -- Conteúdo textual da mensagem trocada
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,                  -- Carimbo de data e hora do envio da mensagem
    is_read TINYINT(1) DEFAULT 0,                                -- Estado de leitura da mensagem (0 = Não Lida, 1 = Lida)
    FOREIGN KEY (sender_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Apaga a mensagem se a conta do emissor for removida
    FOREIGN KEY (receiver_id) REFERENCES users(id) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Apaga a mensagem se a conta do recetor for removida
) ENGINE=InnoDB;