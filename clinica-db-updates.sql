/*
Exercício MySQL - Parte 2

Alunos: Gabriel Barros, Hugo Vinícius
*/

/*
OBS.: Algumas consultas foram feitas utilizando variáveis para realizar subselects e evitar 
erros de safe update sem desabilitar a proteção
*/

/* 1. O paciente Paulo mudou-se para Ilhota */
SET @paulo = (SELECT codp FROM pacientes WHERE nome LIKE "Paulo");
UPDATE pacientes 
	SET cidade = "Ilhota"
		WHERE codp = @paulo;

/* 2. A consulta do médico 1 com o paciente 4 passou para às 12:00 horas do dia 4 de Julho de 2006 */
UPDATE consultas 
	SET `data` = "2006-07-04",
		hora = "12:00:00"
		WHERE codm = 1 AND codp = 4;
    
/* 3. A paciente Ana fez aniversário e sua doença agora é cancer */
SET @ana = (SELECT codp FROM pacientes WHERE nome LIKE "Ana");
UPDATE pacientes
	SET doenca = "cancer"
		WHERE codp = @ana;

/* 4. A consulta do médico Pedro (codf = 3) com o paciente Carlos (codf = 4) passou para uma hora e meia depois */
UPDATE consultas 
	SET hora = ADDTIME(hora, "01:30:00")
		WHERE codm = 3 AND codp = 4;

/* 5. O funcionário Carlos (codf = 4) deixou a clínica */
SET @carlos = (SELECT codf FROM funcionarios WHERE nome LIKE "Carlos");
DELETE FROM funcionarios
	WHERE codf = @carlos;

/* 6. As consultas marcadas após as 19 horas foram canceladas */
SET SQL_SAFE_UPDATES = 0;
DELETE FROM consultas
	WHERE hora > "19:00:00";
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM consultas;

/* 7. Os pacientes com câncer ou idade inferior a 10 anos deixaram a clínica */
/* 8. Os médicos que residem em Biguacu e Palhoca deixaram a clínica */