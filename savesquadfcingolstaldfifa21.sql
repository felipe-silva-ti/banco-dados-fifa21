-- =======================================================
-- 0. CRIANDO E SELECIONANDO O BANCO DE DADOS (A SOLUÇÃO DO ERRO)
-- =======================================================

-- Cria um banco de dados chamado "gestao_esportiva" se ele não existir
CREATE DATABASE IF NOT EXISTS gestao_esportiva;

-- Diz ao sistema para usar esse banco de dados a partir de agora
USE gestao_esportiva;


-- =======================================================
-- 1. CRIAÇÃO DAS TABELAS
-- =======================================================

CREATE TABLE jogadores (
    id_jogador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    posicao VARCHAR(5) NOT NULL,
    overall INT NOT NULL,
    idade INT NOT NULL,
    nacionalidade VARCHAR(50) NOT NULL,
    status_elenco VARCHAR(20) NOT NULL
);

CREATE TABLE historico_vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    nome_jogador VARCHAR(100) NOT NULL,
    posicao VARCHAR(5) NOT NULL,
    overall INT NOT NULL,
    idade INT NOT NULL,
    nacionalidade VARCHAR(50) NOT NULL,
    clube_destino VARCHAR(100) NOT NULL
);

-- =======================================================
-- 2. INSERÇÃO DOS DADOS DO SEU TIME (DML)
-- =======================================================

-- Adiciona os 11 jogadores titulares do seu time principal
INSERT INTO jogadores (nome, posicao, overall, idade, nacionalidade, status_elenco) VALUES 
('Benedikt Günter', 'GK', 87, 22, 'Alemanha', 'Titular'),
('Ralf Neumann', 'LE', 76, 20, 'Alemanha', 'Titular'),
('Mattia Poli', 'ZC', 83, 20, 'Itália', 'Titular'),
('Daniel Testa', 'ZC', 87, 22, 'Itália', 'Titular'),
('Lloyd Ace', 'LD', 81, 23, 'Gales', 'Titular'),
('Samuele Amato', 'VOL', 81, 20, 'Itália', 'Titular'),
('Yannick Crivelli', 'MC', 80, 22, 'Suíça', 'Titular'),
('Pedro Álvares', 'MEI', 85, 23, 'Brasil', 'Titular'),
('Alberto Costa', 'ME', 90, 23, 'Itália', 'Titular'),
('Daniele Lorrai', 'PD', 89, 23, 'Itália', 'Titular'),
('Alex Lins', 'ATA', 89, 21, 'Brasil', 'Titular');

-- Adiciona os jogadores que ficam no banco de reservas
INSERT INTO jogadores (nome, posicao, overall, idade, nacionalidade, status_elenco) VALUES 
('Leonard Dreier', 'GK', 67, 17, 'Alemanha', 'Reserva'),
('Niklas Schmidt', 'LE', 73, 19, 'Alemanha', 'Reserva'),
('Torben Schwabe', 'ZC', 66, 18, 'Alemanha', 'Reserva'),
('Eike Krämer', 'ZC', 71, 19, 'Alemanha', 'Reserva'),
('Anton Frank', 'MC', 78, 23, 'Alemanha', 'Reserva'),
('Marius Agafitei', 'MC', 67, 17, 'Moldávia', 'Reserva'),
('Jacopo Pellegrino', 'ATA', 75, 21, 'Itália', 'Reserva');

-- Registra os ex-jogadores vendidos para os gigantes europeus
INSERT INTO historico_vendas (nome_jogador, posicao, overall, idade, nacionalidade, clube_destino) VALUES 
('Caio Menezes', 'MEI', 88, 22, 'Brasil', 'Real Madrid'),
('Felix Hölzel', 'ATA', 79, 21, 'Alemanha', 'Real Betis'),
('Eivind Sandivik', 'PD', 78, 21, 'Noruega', 'Roma'),
('Antonio Fuchs', 'MEI', 77, 19, 'Suíça', 'West Ham'),
('Kai Werner', 'GK', 75, 20, 'Alemanha', 'Bayern de Munique'),
('Pedro Gomes', 'ATA', 74, 21, 'Brasil', 'Leicester City'),
('Yolan Blaser', 'LE', 72, 22, 'Suíça', 'Waasland-Beveren');

-- =======================================================
-- 3. CONSULTAS E INTELIGÊNCIA DE NEGÓCIO (SELECTs)
-- =======================================================

-- CONSULTA 1: Lista apenas os jogadores TITULARES, ordenados do maior Overall para o menor
SELECT nome, posicao, overall 
FROM jogadores 
WHERE status_elenco = 'Titular' 
ORDER BY overall DESC;

-- CONSULTA 2: Radar de Promessas (Filtra atletas muito jovens, sub-21, de nível alto)
SELECT nome, idade, overall, nacionalidade 
FROM jogadores 
WHERE idade <= 21 AND overall >= 75
ORDER BY overall DESC;

-- CONSULTA 3: Média de Idade e Média de Overall de todo o elenco atual (Análise de Desempenho)
SELECT 
    AVG(idade) AS media_idade_time, 
    AVG(overall) AS media_overall_time 
FROM jogadores;

-- CONSULTA 4: Análise de Mercado (Mostra para quais clubes você mais vendeu atletas)
SELECT clube_destino, COUNT(*) AS quantidade_jogadores_vendidos
FROM historico_vendas
GROUP BY clube_destino
ORDER BY quantidade_jogadores_vendidos DESC;

