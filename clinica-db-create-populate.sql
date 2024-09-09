/*
Exercício MySQL - Parte 1

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
    cidade CHAR(30),
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
    
/* Popular as tabelas: */

/* Ambulatorios */
INSERT INTO ambulatorios (nroa, andar, capacidade)
VALUES (1, 1, 30),
(2, 1, 50),
(3, 2, 40),
(4, 2, 25),
(5, 2, 55);

/* Medicos */
INSERT INTO medicos (codm, nome, idade, especialidade, cpf, cidade, nroa)
VALUES (1, "Joao", 40, "ortopedia", 10000100000, "Florianopolis", 1), 
(2, "Maria", 42, "traumatologia", 10000110000, "Blumenau", 2),
(3, "Pedro", 51, "pediatria", 11000100000, "São José", 2),
(4, "Carlos", 28, "ortopedia", 11000110000, "Joinville", NULL),
(5, "Marcia", 33, "neurologia", 11000111000, "Biguacu", 3);

/* Pacientes CORRIGIR */
INSERT INTO pacientes (codp, nome, idade, cidade, cpf, doenca)
VALUES (1, "Ana", 20, "Florianopolis", 20000200000, "gripe"),
(2, "Paulo", 24, "Palhoca", 20000220000, "fratura"),
(3, "Lucia", 30, "Biguacu", 22000200000, "tendinite"),
(4, "Carlos", 28, "Joinville", 11000110000, "sarampo");

/* Funcionarios */
INSERT INTO funcionarios (codf, nome, idade, cpf, cidade, salario)
VALUES (1, "Rita", 32, 20000100000, "Sao Jose", 1200),
(2, "Maria", 55, 30000110000, "Palhoca", 1220),
(3, "Caio", 45, 41000100000, "Florianopolis", 1100),
(4, "Carlos", 44, 51000110000, "Florianopolis", 1200),
(5, "Paula", 33, 61000111000,"Florianopolis", 2500);

/* Consultas */
INSERT INTO consultas (codm, codp, `data`, hora)
VALUES (1, 1, "2006-06-12", "14:00:00"),
(1, 4, "2006-06-13", "10:00:00"),
(2, 1, "2006-06-13", "09:00:00"),
(2, 2, "2006-06-13", "11:00:00"),
(2, 3, "2006-06-14", "14:00:00"),
(2, 4, "2006-06-14", "17:00:00"),
(3, 1, "2006-06-19", "18:00:00"),
(3, 3, "2006-06-12", "10:00:00"),
(3, 4, "2006-06-19", "13:00:00"),
(4, 4, "2006-06-20", "13:00:00"),
(4, 4, "2006-06-22", "19:30:00");