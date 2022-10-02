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

--Quantidade de turmas dos 2 cursos acima: Excel intermediario e VBA. O código abaixo faz 2 consultas ao mesmo tempo.

SELECT * -- Utilizando or(ou): O and mostra a intercessão o or fornece a união dos dois.
FROM Turmas
WHERE id_curso=1 or id_curso=5

SELECT * -- Utilizando in: O in faz com que o select mostre os registros que estão entre parênteses.
FROM Turmas
WHERE id_curso in (1,5)

-- Quantidade de turmas com exceção dos que se encontram em parênteses.

SELECT * -- Utilizando not in: O not in faz com que o select mostre todos os registros menos os que estão entre parênteses.
FROM Turmas
WHERE id_curso not in (1,5)

--------------------------------------------------------------------------------------------------- Ano de nascimento dos alunos

SELECT DATEPART(year, data_nascimento) --DATEPART é uma instrução do SQL que extrai parte de uma data, onde coloca-se entre parênteses o intervalo e a coluna onde se encontra. 
FROM Alunos -- ou dbo.alunos - Como na instrução anterior utiliza-se uma coluna é necessário referenciar a tabela onde ela se encontra.

SELECT DATEPART(year, data_nascimento) 
FROM Alunos 
Order by data_nascimento -- Coloca em ordem crescente, para visualizar a progressão dos anos.

SELECT DISTINCT DATEPART(year, data_nascimento) -- A instrução DISTINCT faz com que não sejam trazindos os repetidos.
FROM Alunos 
Order by data_nascimento  -- Dará erro, é necessário colocar o nome do campo quando utiliza-se o distinct.

SELECT DISTINCT DATEPART(year, data_nascimento) -- A instrução DISTINCT faz com que não sejam trazindos os repetidos.
FROM Alunos 
Order by 1 -- Nome do campo

-- Também é possivel colocar em ordem decrescente.

SELECT DISTINCT DATEPART(year, data_nascimento) 
FROM Alunos 
Order by 1 DESC --DECRESCENTE

SELECT DISTINCT DATEPART(year, data_nascimento) 
FROM Alunos 
Order by 1 ASC --CRESCENTE: Como esse é o padrão, o ASC é opcional. 

---------------------------------------------------------------------------------------------------------Lista completa de alunos

-- Utilizando e critérios de filtragem no join.
SELECT *
FROM AlunosxTurmas at
	inner join Turmas t on (t.id_turma = at.id_turma)
	inner join Cursos c on (c.id_curso = t.id_curso)
	inner join Alunos a on (a.id_aluno = at.id_aluno and a.sexo = 'M') -- É possivel utilizar 2 critérios de filtragem no mesmo join.

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

-- Ordem das linhas utilizando uma coluna como mandatório da classificação.
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
Order by 2 -- O nome do curso será o mandatório da classificação, ou seja, será ordenado utilizando o nome do curso como críterio.

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
Order by 2, a.sexo -- O resultado será ordenado pelo nome do curso e pelo sexo. 

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