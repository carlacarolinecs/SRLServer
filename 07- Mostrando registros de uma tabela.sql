 -- SELECT para todos os registros
SELECT * FROM dbo.Turmas
SELECT * FROM Turmas
SELECT Turmas.* FROM dbo.Turmas
SELECT Turmas.* FROM Turmas

 -- SELECT para algumas colunas da tabela
SELECT id_turma, id_curso, data_inicio FROM dbo.Turmas
SELECT id_turma, id_curso, data_inicio FROM Turmas

 -- SELECT com alias (apelido) para a tabela
SELECT * FROM dbo.Turmas T
SELECT * FROM Turmas T
SELECT T.* FROM dbo.Turmas T
SELECT T.* FROM Turmas T
SELECT T.id_turma, T.id_curso FROM dbo.Turmas T
SELECT T.id_turma, T.id_curso FROM Turmas T

 -- SELECT com nomes personalizados para campos
SELECT T.id_turma as IDT, T.id_curso as IDC FROM dbo.Turmas T
SELECT T.id_turma IDT, T.id_curso IDC FROM dbo.Turmas T
