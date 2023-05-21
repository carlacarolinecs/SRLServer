-- Alteração de projeto devido a um problema de normatização na tabela Turmas


-- Apagar colunas necessárias da tabela Turmas(para normatiza-la) 

ALTER TABLE Turmas
DROP CONSTRAINT fk_Alunos; -- Retira a especificação de que essa coluna é uma chave estrangeira

ALTER TABLE Turmas
DROP COLUMN id_aluno; -- Deleta-se a coluna

ALTER TABLE Turmas
DROP COLUMN valor_turma;

ALTER TABLE Turmas
DROP COLUMN desconto;

-- Criar uma nova tabela

CREATE TABLE AlunosxTurmas 
(
id_turma int NOT NULL,
id_aluno int NOT NULL,
valor numeric(13,2) NOT NULL,
valor_desconto numeric(3,2),
data_cadastro datetime NOT NULL,
login_cadastro varchar(15) NOT NULL
);

--Informando ao SQL quais colunas são chaves estrangeiras
ALTER TABLE AlunosxTurmas ADD CONSTRAINT fk_turma FOREIGN KEY(id_turma) REFERENCES Turmas(id_turma);
ALTER TABLE AlunosxTurmas ADD CONSTRAINT fk_aluno FOREIGN KEY(id_aluno) REFERENCES Alunos(id_aluno);

-- Agora pode-se adicionar na tabela turmas uma turma de treinamento.

INSERT INTO dbo.Turmas
(id_turma, id_curso, data_inicio, data_termino, data_cadastro, login_cadastro)
VALUES
(1,1, '17/11/2019', '27/12/2019', getdate(), 'CARLACAROLINECS')

SELECT * FROM dbo.Turmas

-- Agora pode-se adicionar um registro na tabela AlunosxTurmas 

INSERT INTO dbo.AlunosxTurmas
(id_turma, id_aluno, valor, valor_desconto, data_cadastro, login_cadastro)
VALUES
(1,10,1200,0.1, getdate(), 'CARLACAROLINECS')

SELECT * FROM dbo.AlunosxTurmas