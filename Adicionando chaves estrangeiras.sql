CREATE TABLE Alunos
( 
id_aluno int PRIMARY KEY NOT NULL,
nome varchar(200) NOT NULL,
data_nascimento date NOT NULL,
sexo varchar(1) NOT NULL,  -- M para Masculino e F para Feminino
data_cadastro datetime NOT NULL,
login_cadastro varchar(15) NOT NULL
);

CREATE TABLE Situacao
(
id_situacao int PRIMARY KEY NOT NULL,
situacao varchar(25) NOT NULL,
data_cadastro datetime NOT NULL,
login_cadastro varchar(15) NOT NULL
);

CREATE TABLE Cursos
(
id_curso int PRIMARY KEY NOT NULL,
curso varchar(200) NOT NULL,
data_cadastro datetime NOT NULL,
login_cadastro varchar(15) NOT NULL
);

CREATE TABLE Turmas 
(
id_turma int PRIMARY KEY NOT NULL,
id_aluno int NOT NULL,
id_curso int NOT NULL,
valor_turma numeric(15,2) NOT NULL,
desconto numeric(3,2) NOT NULL,
data_inicio date NOT NULL,
data_termino date,
data_cadastro datetime NOT NULL,
login_cadastro varchar(15) NOT NULL
);

-- Adicionando chaves estrangeiras, ou melhor, relacionando 2 tabelas. (Informando ao SQL quais colunas são chaves estrangeiras). 
ALTER TABLE Turmas ADD CONSTRAINT fk_Alunos FOREIGN KEY(id_aluno) REFERENCES Alunos(id_aluno);
ALTER TABLE Turmas ADD CONSTRAINT fk_Cursos FOREIGN KEY(id_curso) REFERENCES Cursos(id_curso);

CREATE TABLE Registro_presenca
(
id_turma int NOT NULL,
id_aluno int NOT NULL,
id_situacao int NOT NULL,
data_presenca date NOT NULL,
data_cadastro datetime NOT NULL,
login_cadastro varchar(15) NOT NULL
);

--Informando ao SQL quais colunas são chaves estrangeiras
ALTER TABLE Registro_presenca ADD CONSTRAINT fk_turmasRP FOREIGN KEY(id_turma) REFERENCES Turmas(id_turma);
ALTER TABLE Registro_presenca ADD CONSTRAINT fk_alunosRP FOREIGN KEY(id_aluno) REFERENCES Alunos(id_aluno);
ALTER TABLE Registro_presenca ADD CONSTRAINT fk_situacaoRP FOREIGN KEY(id_situacao) REFERENCES Situacao(id_situacao);

--Excluindo colunas
/*
DROP TABLE Alunos;
DROP TABLE Cursos;
DROP TABLE Situacao;
DROP TABLE Turmas;
DROP TABLE Registro_presenca
*/

-- Excluindo o CONSTRAINT adicionado por meio do comando ALTER TABLE
/*
ALTER TABLE Turmas DROP CONSTRAINT fk_Alunos;
ALTER TABLE Turmas DROP CONSTRAINT fk_Cursos;
ALTER TABLE Registro_presenca DROP CONSTRAINT fk_turmasRP;
ALTER TABLE Registro_presenca DROP CONSTRAINT fk_alunosRP;
ALTER TABLE Registro_presenca DROP CONSTRAINT fk_situacaoRP
*/