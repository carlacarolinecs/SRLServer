/*
Recursos adicionais de SELECT - IN, NOT IN, DISTINCT
*/

------------------------------------------------------------------------------------------------------Total de Turmas por curso

SELECT c.id_curso, c.curso, count(t.id_turma) as Total_turma 
FROM Turmas t
	inner join Cursos c on c.id_curso = t.id_curso
Group by c.id_curso, c.curso

----------------------------------------------------------------------------------------------------Quantidade de turmas por curso
SELECT * -- VBA
FROM Turmas
WHERE id_curso=1 

SELECT * -- Excel intermediario
FROM Turmas
WHERE id_curso=5

--Quantidade de turmas dos 2 cursos acima: Excel intermediario e VBA. O c�digo abaixo faz 2 consultas ao mesmo tempo.

SELECT * -- Utilizando or(ou): O and mostra a intercess�o o or fornece a uni�o dos dois.
FROM Turmas
WHERE id_curso=1 or id_curso=5

SELECT * -- Utilizando in: O in faz com que o select mostre os registros que est�o entre par�nteses.
FROM Turmas
WHERE id_curso in (1,5)

-- Quantidade de turmas com exce��o dos que se encontram em par�nteses.

SELECT * -- Utilizando not in: O not in faz com que o select mostre todos os registros menos os que est�o entre par�nteses.
FROM Turmas
WHERE id_curso not in (1,5)

--------------------------------------------------------------------------------------------------- Ano de nascimento dos alunos

SELECT DATEPART(year, data_nascimento) --DATEPART � uma instru��o do SQL que extrai parte de uma data, onde coloca-se entre par�nteses o intervalo e a coluna onde se encontra. 
FROM Alunos -- ou dbo.alunos - Como na instru��o anterior utiliza-se uma coluna � necess�rio referenciar a tabela onde ela se encontra.

SELECT DATEPART(year, data_nascimento) 
FROM Alunos 
Order by data_nascimento -- Coloca em ordem crescente, para visualizar a progress�o dos anos.

SELECT DISTINCT DATEPART(year, data_nascimento) -- A instru��o DISTINCT faz com que n�o sejam trazindos os repetidos.
FROM Alunos 
Order by data_nascimento  -- Dar� erro, � necess�rio colocar o nome do campo quando utiliza-se o distinct.

SELECT DISTINCT DATEPART(year, data_nascimento) -- A instru��o DISTINCT faz com que n�o sejam trazindos os repetidos.
FROM Alunos 
Order by 1 -- Nome do campo

-- Tamb�m � possivel colocar em ordem decrescente.

SELECT DISTINCT DATEPART(year, data_nascimento) 
FROM Alunos 
Order by 1 DESC --DECRESCENTE

SELECT DISTINCT DATEPART(year, data_nascimento) 
FROM Alunos 
Order by 1 ASC --CRESCENTE: Como esse � o padr�o, o ASC � opcional. 

---------------------------------------------------------------------------------------------------------Lista completa de alunos

-- Utilizando e crit�rios de filtragem no join.
SELECT *
FROM AlunosxTurmas at
	inner join Turmas t on (t.id_turma = at.id_turma)
	inner join Cursos c on (c.id_curso = t.id_curso)
	inner join Alunos a on (a.id_aluno = at.id_aluno and a.sexo = 'M') -- � possivel utilizar 2 crit�rios de filtragem no mesmo join.

-- Ordem das colunas
SELECT c.curso,
	   c.id_curso, -- Define a ordem de colunas
	   at.valor,
	   at.valor_desconto,
	   t.data_inicio,
	   t.data_termino,
	   a.nome,
	   a.sexo
FROM AlunosxTurmas at
	inner join Turmas t on (t.id_turma = at.id_turma)
	inner join Cursos c on (c.id_curso = t.id_curso)
	inner join Alunos a on (a.id_aluno = at.id_aluno)

SELECT c.id_curso,
	   c.curso, -- Define a ordem de colunas
	   at.valor,
	   at.valor_desconto,
	   t.data_inicio,
	   t.data_termino,
	   a.nome,
	   a.sexo
FROM AlunosxTurmas at
	inner join Turmas t on (t.id_turma = at.id_turma)
	inner join Cursos c on (c.id_curso = t.id_curso)
	inner join Alunos a on (a.id_aluno = at.id_aluno)

-- Ordem das linhas utilizando uma coluna como mandat�rio da classifica��o.
SELECT c.id_curso,
	   c.curso, -- Segunda coluna do select (2)
	   at.valor,
	   at.valor_desconto,
	   t.data_inicio,
	   t.data_termino,
	   a.nome,
	   a.sexo
FROM AlunosxTurmas at
	inner join Turmas t on (t.id_turma = at.id_turma)
	inner join Cursos c on (c.id_curso = t.id_curso)
	inner join Alunos a on (a.id_aluno = at.id_aluno)
Order by 2 -- O nome do curso ser� o mandat�rio da classifica��o, ou seja, ser� ordenado utilizando o nome do curso como cr�terio.

SELECT c.id_curso,
	   c.curso, -- Segunda coluna do select (2)
	   at.valor,
	   at.valor_desconto,
	   t.data_inicio,
	   t.data_termino,
	   a.nome,
	   a.sexo
FROM AlunosxTurmas at
	inner join Turmas t on (t.id_turma = at.id_turma)
	inner join Cursos c on (c.id_curso = t.id_curso)
	inner join Alunos a on (a.id_aluno = at.id_aluno)
Order by 2, a.sexo -- O resultado ser� ordenado pelo nome do curso e pelo sexo. 

--Utilizando Where
SELECT c.id_curso,
	   c.curso, -- Segunda coluna do select (2)
	   at.valor,
	   at.valor_desconto,
	   t.data_inicio,
	   t.data_termino,
	   a.nome,
	   a.sexo
FROM AlunosxTurmas at
	inner join Turmas t on (t.id_turma = at.id_turma)
	inner join Cursos c on (c.id_curso = t.id_curso)
	inner join Alunos a on (a.id_aluno = at.id_aluno)
WHERE a.sexo = 'M'
Order by 2, a.sexo