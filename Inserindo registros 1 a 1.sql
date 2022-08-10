-- Adicionando 2 linhas na tabela Alunos:
INSERT INTO dbo.Alunos
(id_aluno, nome, data_nascimento, sexo, data_cadastro, login_cadastro)
VALUES
(1, 'Alan Moraes', '4/9/1989', 'M', '03/08/2022 10:54:00', 'CARLACAROLINECS')

INSERT INTO dbo.Alunos
(id_aluno, nome, data_nascimento, sexo, data_cadastro, login_cadastro)
VALUES
(2, 'Alessandro Soares', '4/10/1989', 'M', '03/08/2022 10:54:00', 'CARLACAROLINECS')

Select * from dbo.Alunos -- Mostra os dados que foram inseridos na tabela Alunos
 


 -- Adicionando 2 linhas na tabela Cursos:
 INSERT INTO dbo.Cursos
(id_curso, curso, data_cadastro, login_cadastro)
VALUES
(1, 'VBA I', '03/08/2022 10:54:00', 'CARLACAROLINECS')

 INSERT INTO dbo.Cursos
(id_curso, curso, data_cadastro, login_cadastro)
VALUES
(2, 'VBA II', '03/08/2022 10:54:00', 'CARLACAROLINECS')

Select * from dbo.Cursos -- Mostra os dados que foram inseridos na tabela Cursos



-- Adicionando 3 linhas na tabela Situação:
INSERT INTO dbo.Situacao
(id_situacao, situacao, data_cadastro, login_cadastro)
VALUES
(1, 'Presença Confirmada', '03/08/2022 10:54:00', 'CARLACAROLINECS')

INSERT INTO dbo.Situacao
(id_situacao, situacao, data_cadastro, login_cadastro)
VALUES
(2, 'Ausente sem Justificativa', '03/08/2022 10:54:00', 'CARLACAROLINECS')

INSERT INTO dbo.Situacao
(id_situacao, situacao, data_cadastro, login_cadastro)
VALUES
(3, 'Ausente com Justificativa', '03/08/2022 10:54:00', 'CARLACAROLINECS')

Select * from dbo.Situacao -- Mostra os dados que foram inseridos na tabela Situação


--Observação:

-- Utilizado para deletar registros individualmente.
DELETE FROM dbo.Alunos
 WHERE id_aluno = 157;

Select * from dbo.Alunos --Para conferir.

-- Mostra quantas linhas a tabela Alunos possui.
Select count(*) from dbo.Alunos