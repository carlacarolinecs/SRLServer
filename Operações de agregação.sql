/*
Operações de agregação no select.
Aulas 13,14,15
*/

------------------------------------- Aula 13: Na prática ----------------------------------------------------------

--------------------------------------------------------------------------------------------- Ganhos com turmas

-- 1° Quanto paga cada aluno matriculado:
SELECT c.curso, t.id_turma, at.valor as Valor_bruto, at.valor*at.valor_desconto as Valor_desconto, 
	   at.valor-(at.valor*at.valor_desconto) as Valor_liquido
From Turmas t
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso

-- 2° Somatório
SELECT c.curso, Sum(at.valor) as Valor_bruto, 
				Sum(at.valor*at.valor_desconto) as Valor_desconto, 
				Sum(at.valor-(at.valor*at.valor_desconto)) as Valor_liquido
From Turmas t -- Precisa estar aqui porque at não tem relação direta com os cursos.
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso
Group by c.curso --É necessário dizer ao SQL quais campos ele vai agrupar.

-- 3° Somátorio por curso x turma:
SELECT c.curso, t.id_turma, Sum(at.valor) as Valor_bruto, 
				Sum(at.valor*at.valor_desconto) as Valor_desconto, 
				Sum(at.valor-(at.valor*at.valor_desconto)) as Valor_liquido
From Turmas t 
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso
Group by c.curso, t.id_turma -- o id_turma também precisa ser agregado, caso contrário dará erro.

-- 4° Arredondamento dos valores
-- round(expressão, n° de casas decimais)
SELECT c.curso, t.id_turma, Sum(at.valor) as Valor_bruto, 
				round(Sum(at.valor*at.valor_desconto), 2) as Valor_desconto, 
				round(Sum(at.valor-(at.valor*at.valor_desconto)), 2) as Valor_liquido
From Turmas t 
	Inner join AlunosxTurmas at on at.id_turma = t.id_turma 
	Inner join Cursos c on c.id_curso = t.id_curso
Group by c.curso, t.id_turma 

----------------------------------------------------------------------------------------------- Ganhos por ano

-- A função year extrai da nossa data de inicio o ano.
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

--A query abaixo dará erro, pq a função de agregação precisa agrupar um campo agrupado (t.id_turma), em outras palavras faltou o Group by.
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
GROUP BY t.id_turma, c.curso -- O nome c.curso tbm precisa estar agregado, caso contrario, dará erro.

-- Utilizando uma subquery como um totalizador de tudo.
SELECT SUM(v.Total)
FROM (
		SELECT t.id_turma, c.curso, SUM(valor) as Total  
		FROM AlunosxTurmas at
			inner join Turmas t on t.id_turma = at.id_turma
			inner join Cursos c on c.id_curso = t.id_curso
		GROUP BY t.id_turma, c.curso
	) v

--COUNT - pode ser utilizado para contar o número de registros.

SELECT t.id_turma, 1 as Total_alunos -- Quando coloca-se a função count vai executar a contagem de registros. Cada linha representa um registro, neste caso um aluno
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

--Também é possivel utilizar SUM nessa query
SELECT t.id_turma, COUNT(id_aluno) as Total_alunos, SUM(at.valor) as Valor_total
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
GROUP BY t.id_turma


--AVG - Averange - Média - Neste caso é a média do valor pago por curso.

SELECT t.id_turma, c.curso, AVG(at.valor) as Média
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso

-- MAX - Utilizado para localizar o máximo de um valor.

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

-- Se quiser utilizar os dois componentes acima em uma só query

SELECT t.id_turma, c.curso, MIN(at.valor) as Minimo, MAX(at.valor) as Maximo
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso

-- Se quiser calcular a diferença entre elas

SELECT t.id_turma, c.curso, MIN(at.valor) - MAX(at.valor) as Diferença
FROM AlunosxTurmas at
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso
GROUP BY t.id_turma, c.curso