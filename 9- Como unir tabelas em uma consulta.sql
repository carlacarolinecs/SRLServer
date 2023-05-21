-- Total de turmas por curso -- Utilizando o inner join
SELECT c.id_curso, c.curso, count(t.id_turma) as Total_turmas
FROM dbo.Turmas t
     inner join dbo.Cursos c 
	 on c.id_curso = t.id_curso
group by c. id_curso, c.curso
-- Sem o join
SELECT c.id_curso, c.curso, count(t.id_turma) as Total_turmas
FROM dbo.Turmas t, dbo.Cursos c 
WHERE c.id_curso = t.id_curso
group by c. id_curso, c.curso


-- Todos os cursos independente se há ou não turmas -- Utilizando o right join
SELECT c.curso, count(t.id_turma) as Total_turmas
FROM dbo.Turmas t
     right join dbo.Cursos c 
	 on c.id_curso = t.id_curso
group by c.curso

-- Lista completa de alunos -- Utilizando mais de um inner join
SELECT a.nome, a.sexo, c.curso, at. valor, at.valor_desconto, t.data_inicio, t.data_termino
FROM dbo.AlunosxTurmas at
    inner join dbo.Turmas t on t.id_turma = at.id_turma
	inner join dbo.Cursos c on c.id_curso = t.id_curso
	inner join dbo.Alunos a on a.id_aluno = at.id_aluno

-- Quantidade de turmas com alunos por curso
SELECT t.id_turma, count(1) Total, c.curso
FROM dbo.Turmas t
    inner join dbo.AlunosxTurmas at on at.id_turma = t.id_turma
	inner join dbo.Cursos c on c.id_curso = t.id_curso
group by c.curso, t. id_turma