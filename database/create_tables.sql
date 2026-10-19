-- ============================================================================
-- PROJETO: TCMatcher - Plataforma de Geolocalização para TCGs
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
-- 1. TABELA: Utilizador
-- DESCRIÇÃO: Tabela principal de contas. Armazena credenciais e localização 
--            de todos os utilizadores (jogadores, gestores de lojas e admins).
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Utilizador (
    id_utilizador INT AUTO_INCREMENT PRIMARY KEY,               -- Identificador único e chave primária do utilizador
    nome VARCHAR(100) NOT NULL,                                  -- Nome completo do utilizador ou nome do responsável
    email VARCHAR(150) NOT NULL UNIQUE,                          -- Endereço de e-mail único para autenticação e contacto
    palavra_passe VARCHAR(255) NOT NULL,                         -- Hash de segurança da palavra-passe de acesso
    tipo_conta ENUM('JOGADOR', 'LOJA', 'ADMIN') NOT NULL DEFAULT 'JOGADOR', -- Distingue o perfil de acesso e permissões
    latitude DECIMAL(10, 8) NULL,                                -- Coordenada de latitude geográfica para o mapa
    longitude DECIMAL(11, 8) NULL,                               -- Coordenada de longitude geográfica para o mapa
    raio_visibilidade_km DECIMAL(5, 2) DEFAULT 5.00,             -- Raio máximo em km definido pelo jogador para encontrar rivais
    visivel_mapa TINYINT(1) DEFAULT 1,                           -- Indicador (1/0) de estado online/visível no mapa de jogo
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP              -- Carimbo de data/hora do registo do utilizador
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. TABELA: JogosTCG
-- DESCRIÇÃO: Catálogo central dos jogos de cartas (TCGs) suportados pela app.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS JogosTCG (
    id_jogo INT AUTO_INCREMENT PRIMARY KEY,                     -- Identificador único e chave primária do jogo
    nome_jogo VARCHAR(100) NOT NULL UNIQUE,                      -- Nome comercial do TCG (ex: 'Pokémon TCG', 'Magic')
    descricao TEXT NULL                                          -- Resumo descritivo ou regras gerais do jogo
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. TABELA: PerfilJogador
-- DESCRIÇÃO: Extensão 1:1 da tabela Utilizador contendo dados específicos do jogador.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PerfilJogador (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,                   -- Identificador único da ficha de perfil
    id_utilizador INT NOT NULL UNIQUE,                          -- Chave estrangeira para o utilizador (relação 1:1)
    nivel_experiencia ENUM('INICIANTE', 'CASUAL', 'COMPETITIVO') DEFAULT 'CASUAL', -- Nível de habilidade do jogador
    bio TEXT NULL,                                              -- Biografia ou apresentação curta exibida no perfil público
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Apaga/atualiza o perfil se o utilizador for removido/alterado
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 4. TABELA: Jogador_TCG
-- DESCRIÇÃO: Tabela de junção (N:M) entre Utilizador e JogosTCG.
--            Associa quais TCGs cada jogador pratica/tem interesse.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Jogador_TCG (
    id_utilizador INT NOT NULL,                                  -- Chave estrangeira que referencia o jogador
    id_jogo INT NOT NULL,                                        -- Chave estrangeira que referencia o jogo TCG
    PRIMARY KEY (id_utilizador, id_jogo),                       -- Chave primária composta para impedir registos duplicados
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Elimina a associação caso o jogador seja apagado
    FOREIGN KEY (id_jogo) REFERENCES JogosTCG(id_jogo) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Elimina a associação caso o TCG seja apagado
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 5. TABELA: Loja
-- DESCRIÇÃO: Extensão 1:1 da tabela Utilizador para contas do tipo 'LOJA'.
--            Guarda dados do estabelecimento físico e informações comerciais.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Loja (
    id_loja INT AUTO_INCREMENT PRIMARY KEY,                      -- Identificador único da loja física
    id_utilizador INT NOT NULL UNIQUE,                          -- Chave estrangeira para a conta de utilizador (relação 1:1)
    nome_loja VARCHAR(150) NOT NULL,                             -- Nome comercial ou público do estabelecimento
    morada VARCHAR(255) NOT NULL,                                -- Endereço físico completo da loja
    telefone VARCHAR(20) NULL,                                   -- Número de contacto telefónico da loja
    horario_funcionamento VARCHAR(100) NULL,                     -- Descrição dos horários e dias de abertura
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Apaga a loja se a conta de utilizador for removida
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 6. TABELA: Eventos_Torneios
-- DESCRIÇÃO: Regista os torneios e eventos organizados pelas lojas.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Eventos_Torneios (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,                   -- Identificador único e chave primária do evento/torneio
    id_loja INT NOT NULL,                                        -- Chave estrangeira da loja organizadora
    id_jogo INT NOT NULL,                                        -- Chave estrangeira do TCG específico do evento
    titulo VARCHAR(150) NOT NULL,                                -- Título público do torneio (ex: 'Friday Night Magic')
    descricao TEXT NULL,                                         -- Detalhes sobre o evento, prémios ou formato
    data_inicio DATETIME NOT NULL,                               -- Data e hora marcadas para o arranque do torneio
    data_fim DATETIME NULL,                                      -- Data e hora previstas para o encerramento do evento
    vagas_maximas INT DEFAULT 16,                                -- Lotação máxima do número de participantes
    preco_inscricao DECIMAL(8, 2) DEFAULT 0.00,                  -- Custo do valor de entrada/taxa de inscrição em Euros
    FOREIGN KEY (id_loja) REFERENCES Loja(id_loja) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Apaga os eventos se a loja for removida
    FOREIGN KEY (id_jogo) REFERENCES JogosTCG(id_jogo) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Apaga os eventos se o TCG associado for removido
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 7. TABELA: Inscricao_Evento
-- DESCRIÇÃO: Tabela de junção (N:M) entre Utilizador e Eventos_Torneios.
--            Controla inscritos e o check-in presencial no evento.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Inscricao_Evento (
    id_inscricao INT AUTO_INCREMENT PRIMARY KEY,                 -- Identificador único do comprovativo de inscrição
    id_evento INT NOT NULL,                                      -- Chave estrangeira do evento/torneio
    id_utilizador INT NOT NULL,                                  -- Chave estrangeira do jogador inscrito
    data_inscricao DATETIME DEFAULT CURRENT_TIMESTAMP,           -- Carimbo de data/hora em que a inscrição foi efetuada
    presenca_confirmada TINYINT(1) DEFAULT 0,                   -- Indicador (1/0) de validação de presença (check-in) na loja
    CONSTRAINT uq_evento_jogador UNIQUE (id_evento, id_utilizador), -- Impede que um jogador se inscreva duas vezes no mesmo evento
    FOREIGN KEY (id_evento) REFERENCES Eventos_Torneios(id_evento) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Elimina a inscrição se o evento for cancelado/apagado
    FOREIGN KEY (id_utilizador) REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Elimina a inscrição se o jogador apagar a conta
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 8. TABELA: Matchs_Historico
-- DESCRIÇÃO: Guarda o registo das partidas disputadas entre dois jogadores.
--            Utilizado para os cálculos de estatísticas e taxa de vitórias.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Matchs_Historico (
    id_match INT AUTO_INCREMENT PRIMARY KEY,                     -- Identificador único do registo da partida
    id_jogador1 INT NOT NULL,                                    -- Chave estrangeira do primeiro participante
    id_jogador2 INT NOT NULL,                                    -- Chave estrangeira do segundo participante
    id_jogo INT NOT NULL,                                        -- Chave estrangeira do TCG disputado na partida
    vencedor_id INT NULL,                                        -- Chave estrangeira do jogador vencedor (NULL em caso de empate)
    resultado_confirmado TINYINT(1) DEFAULT 0,                   -- Validação cruzada (1/0) da submissão por parte do adversário
    data_partida DATETIME DEFAULT CURRENT_TIMESTAMP,             -- Data e hora em que a partida foi efetuada/registada
    CONSTRAINT chk_diferentes_jogadores CHECK (id_jogador1 <> id_jogador2), -- Garante que um jogador não joga contra si próprio
    FOREIGN KEY (id_jogador1) REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Mantém integridade se o jogador 1 for removido
    FOREIGN KEY (id_jogador2) REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Mantém integridade se o jogador 2 for removido
    FOREIGN KEY (id_jogo) REFERENCES JogosTCG(id_jogo) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Mantém integridade se o TCG for removido
    FOREIGN KEY (vencedor_id) REFERENCES Utilizador(id_utilizador) 
        ON DELETE SET NULL ON UPDATE CASCADE                     -- Mantém o histórico da partida mesmo se a conta do vencedor for apagada
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 9. TABELA: Mensagens_Chat
-- DESCRIÇÃO: Regista as mensagens trocadas no chat direto entre utilizadores.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Mensagens_Chat (
    id_mensagem INT AUTO_INCREMENT PRIMARY KEY,                  -- Identificador único e chave primária de cada mensagem
    id_emissor INT NOT NULL,                                     -- Chave estrangeira do utilizador que enviou a mensagem
    id_receptor INT NOT NULL,                                    -- Chave estrangeira do utilizador que recebe a mensagem
    conteudo TEXT NOT NULL,                                      -- Conteúdo textual da mensagem trocada
    data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,               -- Carimbo de data e hora do envio da mensagem
    lida TINYINT(1) DEFAULT 0,                                   -- Estado de leitura da mensagem (0 = Não Lida, 1 = Lida)
    FOREIGN KEY (id_emissor) REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE ON UPDATE CASCADE,                     -- Apaga a mensagem se a conta do emissor for removida
    FOREIGN KEY (id_receptor) REFERENCES Utilizador(id_utilizador) 
        ON DELETE CASCADE ON UPDATE CASCADE                      -- Apaga a mensagem se a conta do recetor for removida
) ENGINE=InnoDB;