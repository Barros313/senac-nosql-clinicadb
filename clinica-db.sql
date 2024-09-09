/*
Exercício MySQL
Alunos: Gabriel Barros, Hugo Vinícius
*/

/* Teste */
-- DROP DATABASE clinica;

/* 
1. Crie um BD com nome Clinica 
*/
CREATE DATABASE IF NOT EXISTS clinica;	
USE clinica;

/* 
2.  Crie as seguintes tabelas neste BD, considerando que os atributos
sublinhados são chaves primárias e os em itálico são chaves
estrangeiras:
 */
 
 /* Ambulatorios */
 CREATE TABLE IF NOT EXISTS ambulatorios (
	nroa INT,
    andar NUMERIC(3) NOT NULL,
    capacidade SMALLINT,
    PRIMARY KEY (nroa)
 );
 
 /* Medicos */
 CREATE TABLE IF NOT EXISTS medicos (
	codm INT,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    especialidade CHAR(20),
    cpf NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    nroa INT,
    PRIMARY KEY (codm),
    FOREIGN KEY (nroa) 
		REFERENCES ambulatorios(nroa)
 );
 
 /* Pacientes */
 CREATE TABLE IF NOT EXISTS pacientes (
	codp INT,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    especialidade CHAR(20),
    cpf NUMERIC(11) UNIQUE,
    doenca VARCHAR(40) NOT NULL,
    PRIMARY KEY (codp)
 );
 
 /* Funcionarios */
 CREATE TABLE IF NOT EXISTS funcionarios (
	codf INT,
    nome VARCHAR(40) NOT NULL,
    idade SMALLINT NOT NULL,
    cpf NUMERIC(11) UNIQUE,
    cidade VARCHAR(30),
    salario NUMERIC(10),
    cargo VARCHAR(20),
    PRIMARY KEY(codf)
 );
 
 /* Consultas */
 CREATE TABLE IF NOT EXISTS consultas (
	codm INT,
    codp INT,
    `data` DATE,
	hora TIME,
    PRIMARY KEY(codm, `data`, hora),
    FOREIGN KEY(codm) 
		REFERENCES medicos(codm),
	FOREIGN KEY (codp)
		REFERENCES pacientes(codp)
 );
 
/* 3. Crie a coluna nroa (int) na tabela Funcionarios */
ALTER TABLE funcionarios ADD nroa INT;

/* 
4. Crie os seguintes índices: 
	• Medicos: CPF (único)
	• Pacientes: doenca
*/
ALTER TABLE medicos ADD INDEX (cpf);
ALTER TABLE pacientes ADD INDEX (doenca);

/* 5. Remover o índice doenca em Pacientes */
DROP INDEX doenca ON pacientes;

/* 6. Remover as colunas cargo e nroa da tabela de Funcionarios */
ALTER TABLE funcionarios 
	DROP COLUMN cargo, 
    DROP COLUMN nroa;