-- Retorna um aluno especifico
SELECT a.*
FROM Alunos a
WHERE a.nome = 'Alvaro Queiroz'

-- Retorna todos os alunos menos o aluno 'Alvaro Queiroz'
SELECT a.*
FROM Alunos a
WHERE a.nome <> 'Alvaro Queiroz'

-- Retorna os alunos que nasceram depois do dia 10/12/2003
SELECT a.*
FROM Alunos a
WHERE a.data_nascimento >= '10/12/2003' --A data tem que estar entre aspas simples.

-- todate('10122003','ddmmyyyy') -- formato de data no ORACLE

/*
Pode-se utilizar os seguintes operadores de compara��o: 
>   Maior
<	Menor
>=	Maior ou igual
<=	Menor ou igual
<>	Diferente
=	Igual
*/

-- N�o � case sensitive, pode-se utilizar maiusculo ou minusculo:
SELECT a.*
FROM Alunos a
WHERE a.sexo = 'M'

SELECT a.*
FROM Alunos a
WHERE a.sexo = 'm'

-- Para adicionar mais de um filtro, mais de uma condi��o utiliza-se o and ou or:
SELECT a.*
FROM Alunos a
WHERE a.sexo = 'M' and a.data_nascimento >= '01/01/2003'

--Tamb�m � possivel utilizar o filtro sem utilizar a tabela toda
SELECT a.nome, a.sexo, year(a.data_nascimento) ano
FROM Alunos a
WHERE a.data_nascimento >= '01/01/2003'

-- Retorna os alunos que pagam acima de 500
SELECT at.*
FROM AlunosxTurmas at
WHERE at.valor >500

-- Tamb�m � possivel realizar equa��es
SELECT at.valor*at.valor_desconto as desconto
FROM AlunosxTurmas at

-- Para identificar o aluno, adicion-se a coluna id_aluno
SELECT at.id_aluno, (at.valor*at.valor_desconto) as desconto
FROM AlunosxTurmas at

-- Para obter a mesma informa��o para aqueles que pagam acima de 500
SELECT at.id_aluno, (at.valor*at.valor_desconto) as desconto
FROM AlunosxTurmas at
WHERE at.valor>500

-- Para obter o valor de desconto bruto, sem um monte de zeros.
SELECT at.id_aluno, (at.valor*at.valor_desconto) as desconto
FROM AlunosxTurmas at
WHERE at.valor_desconto > 0
and at.valor > 500

-- Para n�o mostrar a parte decimal
SELECT at.id_aluno, floor((at.valor*at.valor_desconto)) as desconto
FROM AlunosxTurmas at
WHERE at.valor_desconto > 0
and at.valor > 500

--EXTRA (JOINs)- junta ou uni tabelas

-- Cria-se uma rela��o entre chave estrangeira e primaria
SELECT *
FROM AlunosxTurmas at, Turmas t, Cursos c
WHERE at.id_turma = t.id_turma
and   t.id_curso = c.id_curso

-- Ap�s criar a rela��o pode-se buscar as colunas que desejar
SELECT c.curso, t.data_inicio, t.data_termino, at.valor, (at.valor*at.valor_desconto) as desconto
FROM AlunosxTurmas at, Turmas t, Cursos c
WHERE at.id_turma = t.id_turma
and   t.id_curso = c.id_curso

-- Se quiser o valor final que o aluno pagou pode-se realizar outra opera��o: Est� dando erro.
SELECT c.curso, t.data_inicio, t.data_termino, at.valor as Valor_bruto, 
		(at.valor*at.valor_desconto) as desconto, 
		at.valor-(at.valor*at.valor_desconto) as Valor_liquido
FROM AlunosxTurmas at, Turmas t, Cursos c
WHERE at.id_turma = t.id_turma
and   t.id_curso = c.id_curso

-- Tamb�m � possivel utilizar a fun��o floor em cada um deles.
SELECT c.curso, t.data_inicio, t.data_termino, floor(at.valor) as Valor_bruto, 
		floor(at.valor*at.valor_desconto) as desconto, 
		floor(at.valor-(at.valor*at.valor_desconto)) as Valor_liquido
FROM AlunosxTurmas at, Turmas t, Cursos c
WHERE at.id_turma = t.id_turma
and   t.id_curso = c.id_curso
