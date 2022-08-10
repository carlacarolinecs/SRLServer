--Excluindo Tabelas
/*
DROP TABLE Alunos;
DROP TABLE Cursos;
DROP TABLE Situacao;
DROP TABLE Turmas;
DROP TABLE Registro_presenca
*/

-- Excluindo colunas com chaves estrangeiras (Excluindo o CONSTRAINT adicionado por meio do comando ALTER TABLE)  
/*
ALTER TABLE Turmas DROP CONSTRAINT fk_Alunos;
ALTER TABLE Turmas DROP CONSTRAINT fk_Cursos;
ALTER TABLE Registro_presenca DROP CONSTRAINT fk_turmasRP;
ALTER TABLE Registro_presenca DROP CONSTRAINT fk_alunosRP;
ALTER TABLE Registro_presenca DROP CONSTRAINT fk_situacaoRP
*/

-- Excluindo colunas
/*
ALTER TABLE Turmas DROP CONSTRAINT fk_Alunos; -- Retira a especificação de que essa coluna é uma chave estrangeira
ALTER TABLE Turmas DROP COLUMN id_aluno; -- Deleta-se a coluna
ALTER TABLE Turmas DROP COLUMN valor_turma;
ALTER TABLE Turmas DROP COLUMN desconto;
*/

-- Excluindo linhas (Utilizado para deletar registros individualmente)
/*
DELETE FROM dbo.Alunos
 WHERE id_aluno = 157 
*/

