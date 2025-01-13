-- Criação do banco de dados
CREATE DATABASE biblioteca;

-- Conectar ao banco de dados
\c biblioteca;

-- Tabela Usuario
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(22),
    data_nascimento DATE,
    tipo_usuario VARCHAR(50),
    login VARCHAR(50) UNIQUE
);

-- Tabela Acesso
CREATE TABLE Acesso (
    id_acesso SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    data_acesso TIMESTAMP NOT NULL
);

-- Tabela Autor
CREATE TABLE Autor (
    id_autor SERIAL PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL,
    descricao_autor TEXT
);

-- Tabela Categoria
CREATE TABLE Categoria (
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL,
    descricao_categoria TEXT
);

-- Tabela Livro
CREATE TABLE Livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    editora VARCHAR(100),
    ano_publicado INT,
    edicao VARCHAR(50),
    disponibilidade BOOLEAN DEFAULT TRUE,
    isbn VARCHAR(13) UNIQUE,
    id_autor INT REFERENCES Autor(id_autor) ON DELETE SET NULL,
    id_categoria INT REFERENCES Categoria(id_categoria) ON DELETE SET NULL
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    id_fornecedor SERIAL PRIMARY KEY,
    nome_fornecedor VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) UNIQUE,
    endereco TEXT
);

-- Tabela Livro_Fornecido (associação)
CREATE TABLE Livro_Fornecido (
    id_livro INT REFERENCES Livro(id_livro) ON DELETE CASCADE,
    id_fornecedor INT REFERENCES Fornecedor(id_fornecedor) ON DELETE CASCADE,
    data_aquisicao DATE,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_livro, id_fornecedor)
);

-- Tabela Emprestimo
CREATE TABLE Emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    id_livro INT REFERENCES Livro(id_livro) ON DELETE CASCADE,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    status VARCHAR(50)
);

-- Tabela Multa
CREATE TABLE Multa (
    id_multa SERIAL PRIMARY KEY,
    id_emprestimo INT REFERENCES Emprestimo(id_emprestimo) ON DELETE CASCADE,
    data_geracao DATE NOT NULL,
    status_pagamento BOOLEAN DEFAULT FALSE,
    valor NUMERIC(10, 2) NOT NULL
);

-- Tabela Doacao
CREATE TABLE Doacao (
    id_doacao SERIAL PRIMARY KEY,
    id_livro INT REFERENCES Livro(id_livro) ON DELETE CASCADE,
    nome_doador VARCHAR(100),
    data_doacao DATE NOT NULL,
    quantidade INT NOT NULL
);

-- Tabela Evento
CREATE TABLE Evento (
    id_evento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tema VARCHAR(100),
    publico_alvo TEXT,
    data DATE NOT NULL
);

-- Tabela Participa_Evento
CREATE TABLE Participa_Evento (
    id_evento INT REFERENCES Evento(id_evento) ON DELETE CASCADE,
    id_usuario INT REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    quantidade_participantes INT,
    PRIMARY KEY (id_evento, id_usuario)
);

