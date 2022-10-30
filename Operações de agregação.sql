/*
Opera��es de agrega��o no select.
Aulas 13,14,15
*/

------------------------------------- Aula 13: Na pr�tica ----------------------------------------------------------

--------------------------------------------------------------------------------------------- Ganhos com turmas

-- 1� Quanto paga cada aluno matriculado:
SELECT c.curso, t.id_turma, at.valor as Valor_bruto, at.valor*at.valor_desconto as Valor_desconto, 
	   at.valor-(at.valor*at.valor_desconto) as Valor_liquido
From Turmas t
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso

-- 2� Somat�rio
SELECT c.curso, Sum(at.valor) as Valor_bruto, 
				Sum(at.valor*at.valor_desconto) as Valor_desconto, 
				Sum(at.valor-(at.valor*at.valor_desconto)) as Valor_liquido
From Turmas t -- Precisa estar aqui porque at n�o tem rela��o direta com os cursos.
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso
Group by c.curso --� necess�rio dizer ao SQL quais campos ele vai agrupar.

-- 3� Som�torio por curso x turma:
SELECT c.curso, t.id_turma, Sum(at.valor) as Valor_bruto, 
				Sum(at.valor*at.valor_desconto) as Valor_desconto, 
				Sum(at.valor-(at.valor*at.valor_desconto)) as Valor_liquido
From Turmas t 
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso
Group by c.curso, t.id_turma -- o id_turma tamb�m precisa ser agregado, caso contr�rio dar� erro.

-- 4� Arredondamento dos valores
-- round(express�o, n� de casas decimais)
SELECT c.curso, t.id_turma, Sum(at.valor) as Valor_bruto, 
				round(Sum(at.valor*at.valor_desconto), 2) as Valor_desconto, 
				round(Sum(at.valor-(at.valor*at.valor_desconto)), 2) as Valor_liquido
From Turmas t 
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso
Group by c.curso, t.id_turma 

----------------------------------------------------------------------------------------------- Ganhos por ano

-- A fun��o year extrai da nossa data de inicio o ano.
SELECT year(t.data_inicio) as Ano, Sum(at.valor) as Valor_bruto, 
				round(Sum(at.valor*at.valor_desconto), 0) as Valor_desconto, 
				round(Sum(at.valor-(at.valor*at.valor_desconto)), 0) as Valor_liquido
From Turmas t 
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso
Group by  year(t.data_inicio)

------------------------------------- Aula 14: Como usar ----------------------------------------------------------

-- SUM- Soma uma coluna ou grupos de elementos dessa coluna.

SELECT SUM(valor) FROM AlunosxTurmas
SELECT SUM(valor) as Total FROM AlunosxTurmas

--A query abaixo dar� erro, pq a fun��o de agrega��o precisa agrupar um campo agrupado (t.id_turma), em outras palavras faltou o Group by.
SELECT t.id_turma, SUM(valor) as Total  
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma

--Corrigindo:
SELECT t.id_turma, SUM(valor) as Total  
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
GROUP BY t.id_turma

-- Para saber a qual curso essas turmas pertencem, adiciona-se o campo c.curso
SELECT t.id_turma, c.curso, SUM(valor) as Total  
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso -- O nome c.curso tbm precisa estar agregado, caso contrario, dar� erro.

-- Utilizando uma subquery como um totalizador de tudo.
SELECT SUM(v.Total)
FROM (
		SELECT t.id_turma, c.curso, SUM(valor) as Total  
		FROM AlunosxTurmas at
			inner join Turmas t on t.id_turma = at.id_turma
			inner join Cursos c on c.id_curso = t.id_curso
		GROUP BY t.id_turma, c.curso
	) v

--COUNT - pode ser utilizado para contar o n�mero de registros.

SELECT t.id_turma, 1 as Total_alunos -- Quando coloca-se a fun��o count vai executar a contagem de registros. Cada linha representa um registro, neste caso um aluno
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma

SELECT t.id_turma, COUNT(id_aluno) as Total_alunos
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
GROUP BY t.id_turma

SELECT t.id_turma, COUNT(1) as Total_alunos
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
GROUP BY t.id_turma

--Tamb�m � possivel utilizar SUM nessa query
SELECT t.id_turma, COUNT(id_aluno) as Total_alunos, SUM(at.valor) as Valor_total
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
GROUP BY t.id_turma


--AVG - Averange - M�dia - Neste caso � a m�dia do valor pago por curso.

SELECT t.id_turma, c.curso, AVG(at.valor) as M�dia
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso

-- MAX - Utilizado para localizar o m�ximo de um valor.

SELECT t.id_turma, c.curso, MAX(at.valor) as Maior_valor
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso

-- MIN - Utilizado para localizar o minimo de um valor.

SELECT t.id_turma, c.curso, MIN(at.valor) as Menor_valor
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso

-- Se quiser utilizar os dois componentes acima em uma s� query

SELECT t.id_turma, c.curso, MIN(at.valor) as Minimo, MAX(at.valor) as Maximo
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso

-- Se quiser calcular a diferen�a entre elas

SELECT t.id_turma, c.curso, MIN(at.valor) - MAX(at.valor) as Diferen�a
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso