/*
Fun��es de texto (PARTE 1: Video 17)

S�o fun��es que normalmente vamos utilizar para fazer compara��es ou para identificar conjuntos de caracteres 
ou o n�mero do caracter na tabela ASCII:

- ASCII
- NCHAR
- CHAR
- CHARINDEX
- CONCAT
- CONCAT_WS
- DIFFERENCE

*/

---- ASCII
-- A fun��o ASCII pede uma express�o do tipo varchar com apenas um caracter.

SELECT ascii('a') -- Na tabela de c�digos ASCII o a minusculo equivale ao n�mero 97.
SELECT ascii('A') -- Na tabela de c�digos ASCII o A maiusculo equivale ao n�mero 65.
SELECT ascii('9') -- Na tabela de c�digos ASCII o n�mero 9 equivale ao n�mero 57.

-- Se voc� tentar identificar o c�digo ASCII de uma frase ou mais de um caracter. A fun��o far� a identifica��o apenas do 1� caracter.
SELECT ascii('Alessandro') -- Resultado 65

---- NCHAR -> Converte um c�digo ASCII do tipo int em um valor de caracter.
-- A fun��o NCHAR � o inverso da fun��o ASCII

SELECT nchar(97) -- Resultado a
SELECT nchar(65) -- Resultado A
SELECT nchar(57) -- Resultado 9

---- CHAR -> Se esquecer a anterior pode utilizar essa.
-- Converte um c�digo ASCII do tipo int em um valor de caracter. Al�m disso, a fun��o CHAR � o inverso da fun��o ASCII.

SELECT char(97) -- Resultado a
SELECT char(65) -- Resultado A
SELECT char(57) -- Resultado 9

---- CHARINDEX  -> Pesquisa um caracter em uma sequencia de 8000 caracteres.
-- O primeiro argumento desta fun��o � o caracter que se deseja encontrar no segundo argumento.

SELECT charindex('a', 'Trovato') -- Resultado = 5

-- Essa fun��o retorna o index, ou seja, a posi��o do caracter que se encontra no primeiro argumento, dentro do segundo argumento, contando a partir do terceiro argumento.
SELECT charindex('a', 'Trovato', 6) -- Tamb�m � possivel pesquisar a partir de uma determinada posi��o; Resultado = 0.

-- Deseja-se pesquisar uma palavra dentro de uma string completa, a partir da posi��o n�mero 1.
-- O padr�o come�a por um, ent�o n�o faz diferen�a colocar ou n�o.
SELECT charindex('carvalho', 'carla caroline carvalho silva', 1)

--Essa fun��o tamb�m pode ser utilizada se voc� deseja procurar textos em campos ou tabelas.
SELECT * FROM Alunos
SELECT a.nome, charindex('Prado', a.nome,1) FROM Alunos a -- Para encontrar o sobrenome Prado em uma coluna da tabela Alunos

-- Para mostrar apenas aqueles que tem o sobrenome Prado utiliza-se o WHERE:
SELECT a.nome, charindex('Prado', a.nome,1) 
FROM Alunos a 
WHERE convert(int, charindex('Prado',a.nome, 1))>0 --Precia converter para inteiro para depois colocar o resultado em uma condi��o.

--ou

SELECT a.nome, charindex('Prado', a.nome,1) 
FROM Alunos a 
WHERE  charindex('Prado',a.nome, 1)<>'0'

---- CONCAT -> Essa fun��o concatena valores

SELECT concat('Alessandro',' ', 'Trovato')
SELECT concat('Alessandro',' || ', 'Trovato')

-- Tamb�m � possivel concatenar sem a fun��o:
SELECT 'Alessandro' + ' ' +  'Trovato' 

-- Podemos utilizr a fun��o dentro das nossas querys de BD:
SELECT concat(a.nome,' - ', c.curso) as "Nome do aluno - Curso"
FROM Alunos a
	inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso

---- CONCAT_WS -> Permite concatenar varios campos utilizando um separador e ela faz isso separadamente sem que seja necess�rio posicionar o separador entre cada campo.

SELECT concat_WS('-', 'Carla', 'Caroline', 'Carvalho', 'Silva')

-- O 1� argumento desta fun��o � o separador, ap�s isso � possivel inserir varias express�es para ela realizar a fun��o.
-- Tamb�m � possivel fazer isso utilizando o nosso BD:
SELECT concat_WS('-', a.nome, c.curso,
				 'In�cio: '+ convert(char, t.data_inicio),
				 'Termino: '+ convert(char, t.data_termino)) 
FROM Alunos a
	inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso

-- Para eliminar os espa�amentos adicionais utilize o trim() antes da conver��o.
SELECT concat_WS('-', a.nome, c.curso,
				 'In�cio: '+ trim(convert(char, t.data_inicio)),
				 'Termino: '+ trim(convert(char, t.data_termino))) 
FROM Alunos a
	inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso

---- DIFFERENCE -> Essa fun��o utiliza um escala de 0 a 4,
				-- Onde 0 = N�o h� similaridade alguma entre as strings e 4 = H� muita similaridade entre as strings.

SELECT difference('Alessandro', 'Alexsandro') -- Resultado = 4
SELECT difference('Alessandro', 'Alex') -- Resultado = 3
SELECT difference('Alessandro', 'Sandro') -- Resultado = 1
SELECT difference('Alessandro', 'Excel') -- Resultado = 1
SELECT difference('Alessandro', 'Youtube') -- Resultado = 0

/*
Fun��es de texto (PARTE 2: Video 18)
	- FORMAT
	- LEFT
	- RIGHT
	- LEN
	- LOWER
	- UPPER
*/

---- FORMAT -> Retorna um valor formatado e a cultura opcional(especificar)
			-- Para os dados dos tipos gerais usar CAST ou CONVERT
			
SELECT convert(char, getdate(), 103) -- dd/mm/yyyy

-- Tamb�m � possivel utilizar variavel em nossos selects:
/*
DECLARE @dt DATETIME = convert(char, getdate(), 103)
SELECT @dt  

	Se retirar de comentario mostrar� um erro na declara��o seguinte(ondinhas em baixo da declara��o),
	mas n�o � um erro, apenas mostra isso devido ao fato de a vari�vel j� haver sido declarada anteriormente.
*/

/*
DECLARE @dt DATETIME = getdate()
SELECT format(@dt, 'd', 'en-US') as Americano,
	   format(@dt, 'd', 'zh-cn') as Chines_Simplificado,
	   format(@dt, 'd', 'de-de') as "Alem�o",
	   format(@dt, 'D', 'en-US') as Americano, -- D maiusculo deixa por extenso
	   format(@dt, 'D', 'zh-cn') as Chines_Simplificado, -- D maiusculo deixa por extenso
	   format(@dt, 'D', 'de-de') as "Alem�o" -- D maiusculo deixa por extenso
*/

DECLARE @dt DATETIME = getdate()
SELECT format(1001500, '##-####-##') as cod_prod

--Tamb�m � possivel utilizar a fun��o em nosso banco de dados
-- Quero formatar o campo at.valor do tipo numerico, no padr�o americano.

SELECT format(at.valor, 'N', 'en-US') as Formato_Americano,
	   format(at.valor, 'G', 'en-US') as Formato_Geral,
	   format(at.valor, 'C', 'pt-BR') as Formato_Monetario_BR,
	   format(at.valor, 'C', 'en-US') as Formato_Monetario_US,
	   format(at.valor, 'C', 'de-de') as Formato_Monetario_AL,
	   format(at.valor, 'C', 'de-at') as Formato_Monetario_AUS
FROM AlunosxTurmas at

---- LEFT -> Extrai caracteres a esquerda de um texto ou campos.

SELECT left('Alessandro Trovato',10) -- Pede para mostrar os 10 primeiros caracteres.
SELECT left('Este � um curso de SQL',18) -- Pede para mostrar os 18 primeiros caracteres.

-- Utilizando campos do BD:
SELECT distinct left(a.nome, 5)
FROM Alunos a

---- RIGHT -> Extrai caracteres a direita de um texto ou campos.
SELECT right('Alessandro Trovato',7) -- Pede para mostrar os 7 ultimos caracteres.
SELECT right('Este � um curso de SQL',12) -- Pede para mostrar os 12 ultimos caracteres.

-- Utilizando campos do BD:
SELECT distinct right(a.nome, 5)
FROM Alunos a

-- Al�m disso, � possivel concatenar o left e o right:
SELECT left(a.nome, 5) + right(a.nome, 5)
FROM Alunos a

---- LEN -> Retorna o tamanho do campo
		 -- Essa fun��o s� retorna um argumento. Ela retorna o total de caracteres que se encontra nele.

SELECT len('Alessandro Trovato') 
SELECT len('Este � um curso de SQL')

-- Tamb�m � possivel verificar o tamanho dos campos:

SELECT a.nome, len(a.nome) as Tamanho
FROM Alunos a
SELECT a.nome, max(len(a.nome)) as Tamanho
FROM Alunos a
SELECT a.nome, min(len(a.nome)) as Tamanho
FROM Alunos a

---- UPPER -> Converte os caracteres para maiusculo.
		   -- Todos os nomes s�o convertidos para letras maiusculas.

SELECT upper('Alessandro Trovato') 

-- Tamb�m � possivel utilizar a fun��o em BD.
SELECT upper(a.nome) as Nome_Alunos
FROM Alunos a		 

---- LOWER -> Converte os caracteres para minusculo.
		   -- Todos os nomes s�o convertidos para letras minusculo.

SELECT lower('ALESSANDRO TROVATO') 

-- Tamb�m � possivel utilizar a fun��o em BD.
SELECT lower(a.nome) as Nome_Alunos
FROM Alunos a	

/*
Fun��es de texto (PARTE 3: Video 19)
	- LTRIM - Serve para retirar espa�os a esquerda. ( L de left)
	- RTRIM - Serve para retirar espa�os extras a direita de uma string. (R de right)
	- PATINDEX
	- REPLACE
	- REPLICATE
	- REVERSE
*/

---- LTRIM -> Serve para retirar espa�os a esquerda. ( L de left)
		   -- Essa fun��o possui apenas um argumento. Ela precisa apenas da express�o nvarchar.

SELECT ltrim('                 Alessandro Trovato')
SELECT ltrim('x	               Alessandro Trovato')  -- Se houver qualquer caracter antes desses espa�os o espa�o n�o ser� eliminado. Essa fun��o apenas remove espa�os livres a esquerda, n�o entre palavras.

-- Utilizando o conceito de vari�vel:
declare @varTexto varchar(50) -- Declarando uma variavel chamada varTexto que ser� do tipo varchar com 50 posi��es.
	set @varTexto = '             Este � um texto para teste no LTRIM.' -- O comando set vai fazer com que a variavel seja inicializada.

SELECT ltrim(@varTexto)as teste;

-- Outra forma de fazer isso �(mudei o nome apenas para evitar o erro, pois a variavel vartexto j� foi declarada anteriormente:
declare @varstring varchar(50) -- Declarando uma variavel chamada varstring que ser� do tipo varchar com 50 posi��es.
	set @varstring = '            Este � um texto para teste no LTRIM.' -- O comando set vai fazer com que a variavel seja inicializada.

SELECT Resultado = ltrim(@varstring)
 
---- RTRIM -> Serve para retirar espa�os a direita. ( L de right)
		   -- Essa fun��o possui apenas um argumento. Ela precisa apenas da express�o nvarchar.

SELECT rtrim('Alessandro Trovato                 ')
SELECT rtrim('Alessandro Trovato                x')  -- Se houver qualquer caracter ap�s esses espa�os o espa�o n�o ser� eliminado. Essa fun��o apenas remove espa�os livres a direita, n�o entre palavras.

SELECT len(rtrim('Alessandro Trovato                 ')) -- Ao utilizar a fun��o len() � possivel verificar a quantidade de caracteres, contudo, como a fun��o len() desconsidera os espa�os livres a direita, a quantidade de caracteres � a mesma de quando n�o utiliza-se o RTRIM. Observe:
SELECT len('Alessandro Trovato                 ')

SELECT len(rtrim('Alessandro Trovato                x')) -- Se houver qualquer caracter ap�s esses espa�os, os (caracteres referentes aos) espa�os ser�o contados. Observe:
SELECT len('Alessandro Trovato                x')

-- Utilizando o conceito de vari�vel:
declare @varText varchar(50) -- Declarando uma variavel chamada varText que ser� do tipo varchar com 50 posi��es.
	set @varText = 'Este � um texto para teste no RTRIM.                 ' -- O comando set vai fazer com que a variavel seja inicializada.

SELECT rtrim(@varText)

---- PATINDEX -> Retorna a posi��o inicial da primeira ocorr�ncia de um padr�o.

SELECT patindex('%tro%', 'Alessandro Trovato') -- Esse controle (%  %) indica que a busca do termo tro vai ocorrer n�o importa se est� no come�o, no meio ou no fim.
-- Quando voc� utiliza o percentual entre strings significa que  esse texto que est� no meio pode estar em qualquer posi��o em nosso texto. Isso � �timo para fazer buscas de textos em strings grandes.
-- Retornar� o n�mero 12. Doze indica que a palavra tro ou a express�o que ele est� procurando come�a�na posi��o 12. 

-- Outro exemplo:
SELECT patindex('%a', 'Ter�a'); -- Resultado 5
-- A query acima mostra a posi��o da letra 'a' dentro da string ou palavra que termine com a letra a.
SELECT patindex('%a', 'Sabado'); -- Resultado 0 porque a palavra sabado n�o termina com a.
SELECT patindex('%a', 'A vi�o sem asa, fogueira sem brasa') -- Resultado 34

-- Tamb�m � possivel utilizar o percentual em outra posi��o.
SELECT patindex('a%', 'Trovato') -- Procura a letra a no come�o da string ou em qualquer outra posi��o que come�a com a letra a.
SELECT patindex('a%', 'Alessandro')-- Se trocar Alessandro por trovato voc� encontrar� a posi��o n�mero 1.

-- Tamb�m � possivel nomear a query da seguinte forma:
SELECT posicao=patindex('%At%', 'Alessandro Trovato') -- Independente se colocar At ou at ir� resultar no n�mero 16.
SELECT posicao=patindex('%dro_Trov%', 'Alessandro Trovato')-- Tem que colocar os percentuais se n�o resultar� em zero.

---- SUBSTRING -> Extrai um texto a partir de uma posi��o especifica.
SELECT substring('Aqui � o canal do Alessandro Trovato',30,7) 

-- Utilizando vari�vel:
declare @varTexto3 varchar(100)  -- Declarando uma vari�vel chamada varTexto3. Ela vai ser do tipo varchar de 100 posi��es.
	set @varTexto3 = 'Aqui � o canal do Alessandro Trovato no Youtube.' -- N�s vamos iniciar a nossa vari�vel que vai ser igual ao texto entre aspas.
SELECT substring(@varTexto3, 1, 7) -- Mostrar a partir da posi��o 1 com 7 caracteres mostrados.

-- A query acima resultar� em "Aqui �". Os 7 primeiros caracteres, mas n�o � isso que queremos, por isso, substituiremos o n�mero por patindex(). Observe:
SELECT substring(@varTexto3, patindex('%Trovato%', @varTexto3), 7) -- Deseja-se encontrar o nome Trovato dentro da vari�vel @varTexto3
-- O comando patindex() � utilizado na query anterior para mostrar a posi��o em que se encontra o nome Trovato, ent�o, a partir desta posi��o mostrar� 7 caracteres.
-- patindex('%Trovato%', @varTexto3) -- Resultar� na posi��o 30.

---- REPLACE -> Substitui caracteres em um campo.

SELECT replace('Alessandro Trovato', 'a', 'x') -- Na express�o (string) ser� substituido o 'a' pelo 'x'.

-- Tamb�m � possivel fazer a substitui��o de forma aninhada.
SELECT replace(replace('Alessandro Trovato', 'a', 'x'), 'o', '?') -- Como o primeiro argumento � uma express�o podemos utilizar o texto retornado da fun��o replace utilizado anteriormente.

-- Vamos utilizar o nosso banco de dados:
SELECT a.nome, a.data_nascimento, a.sexo
FROM Alunos a
-- Vamos fazer o replace no campo sexo:
SELECT a.nome, a.data_nascimento, replace(a.sexo, 'M', 'Masculino') as sexo -- Demos um replace no campo sexo, mas n�o foi possivel fazer um replace no F, se eu colocar essa fun��o encadeada em outro replace n�o dar� certo.
FROM Alunos a 

-- Um exemplo bem tipico da fun��o replace � para os campos de CPF em BD. 
-- Utilizando vari�veis:
declare @cpf varchar(15);
	set @cpf = '111.111.111-11';
SELECT replace(@cpf, '.', ' ') -- Tirando pontos
SELECT replace(@cpf, '-', ' ') -- tirando h�fen
SELECT replace(replace(@cpf, '-', ' '), '-', ' ') -- Tirando os 2 ao mesmo tempo.

---- REPLICATE -> Replica o que est� no primeiro argumento o n�mero de vezes que eu definir no segundo argumento.

SELECT replicate('x', 20) -- Replica a letra x vinte vezes.

-- Tamb�m � possivel fazer com que todos os nomes tenham um tamanho fixo de coluna.
--Passo 1
SELECT * FROM Alunos -- Os elementos da coluna nomes tem tamanhos distintos.
SELECT len(nome) FROM Alunos -- Cada aluno possui um tamanho diferente de nome.
--Passo 2
SELECT nome + replicate('x', 50-len(nome))
FROM Alunos
-- Passo 3
SELECT len(nome + replicate('x', 50-len(nome))) as tamanho
FROM Alunos

---- REVERSE -> Inverte os caracteres da string.
SELECT reverse('Alessandro Trovato')
SELECT reverse(nome) FROM Alunos

/*
Fun��es de texto (PARTE 4: Video 20)
	- STRING_AGG
	- SPACE
	- STUFF
*/

---- SPACE -> Gera uma string ou um conjunto de espa�os a partir de uma instru��o.

SELECT 'Alessandro' + space(25) --  Concatenar� o nome com 25 espa�os.
SELECT 'Alessandro' + space(25)+ 'x' -- Para visualizar os espa�os podemos colocar a letra 'x' no final.

-- Utilizando vari�veis:
declare @vnome varchar(50); -- Declarando uma vari�vel chamada vnome, do tipo varchar com 50 posi��es.
	set @vnome = 'Alessandro Trovato' -- N�s vamos iniciar a vari�vel(vnome) que vai ser igual a string 'Alessandro Trovato'.
SELECT @vnome + space(50-len(@vnome)) -- space(50-len(@vnome)) -> Espa�os proporcionais a 50 desde que subtraia o tamanho do nome da minha vari�vel.

-- Se ao onv�s da vari�vel colocassemos o nome de um campo pertencente a um banco de dados, subtrairia o tamanho dos elementos deste capo de tamanho fixo.
SELECT a.nome + space(60-len(a.nome)) + a.sexo -- Ir� colocar o campo sexo para verificar como ficar� o espa�o.
FROM Alunos a

SELECT a.nome + space(60-len(a.nome)) + a.sexo,
	   len(a.nome + space(60 -len(a.nome))+a.sexo) -- Para mostrar o tamanho.
FROM Alunos a
-- Porque o resultado da query acima tem tamanho de 61 caracteres? R= Esse caracter adicional foi dado pelo caracter de sexo.

---- STRING_AGG -> Concatena os valores das express�es de cadeias de caracteres e coloca os valores do separador entre eles.
				-- O separador n�o � adicionado ao final da cadeia de caracteres.
				-- Seria o mesmo equivalente a fun��o unir texto do excel.
				-- Os valores nulls n�o s�o exibidos.

SELECT string_agg(convert(nvarchar(max), sexo), ',') as Registro -- Gerou um �nico registro com todos os sexos da tabela separados por virgula.
FROM Alunos 

-- Substitua o que for Null por N para aparecer.
SELECT string_agg(convert(nvarchar(max), isnull(sexo, 'N')), '-') as Registro -- isnull(sexo, 'N') -> Substitui o sexo que era Null por N.
FROM Alunos

-- A string_agg consegue retornar nulos desde que ocorra a substitui��o desses nulos por algum outro caracter.
SELECT datepart(year, data_nascimento) ano, 
	   string_agg(convert(nvarchar(max), isnull(sexo, '0')), '-')
FROM Alunos
Group by datepart(year, data_nascimento)
Order by 1
-- A query acima mostrar� os sexos agrupados conforme o ano de nascimento dos alunos, ordenados de forma crescente.

-- Outra forma de obter o mesmo resultado � utilizando o comando within:
SELECT datepart(year, data_nascimento) ano, -- Select do ano de nascimento dos alunos.
	   string_agg(convert(nvarchar(max), isnull(sexo, '0')), '-')-- Faz o agrupamento do sexo substituindo o null por 0
			within group( order by datepart(year, data_nascimento) asc) as registro
FROM Alunos
Group by datepart(year, data_nascimento) -- Agrupar por ano

---- STUFF -> Substitui uma string de caracter a partir de uma posi��o pr� determinada.

SELECT stuff('abcdefghi', 3,5, '12345') -- Estou informando a fun��o stuff que 5 caracteres desta string 'abcdefghi' ser� substituida por '12345' a partir da quinta posi��o.

-- Utilizando vari�veis:
declare @vProcura varchar(50); -- Declarando uma vari�vel chamada vProcura, do tipo varchar com 50 posi��es.
declare @vSubstit varchar(30); -- Declarando uma vari�vel chamada vSubstit, do tipo varchar com 30 posi��es.
	set @vProcura = 'Eu, xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx, autorizo...' -- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -> 30 posi��es
	set @vSubstit = ' Alessandro Trovato' -- ' Alessandro Trovato' -> N�o tem 30 posi��es.

-- Como o nome 'Alessandro Trovato' n�o possui 30 posi��es � preciso adicionar espa�os para realizar a troca, para isso utilizamos o comando space.
SELECT stuff(@vProcura, 5,30,@vSubstit + space(30-len(@vSubstit)))

-- Contudo, em um contrato esses espa�os ficariam inadequados, por isso, para tirar esses espa�os podemos utilizar o comando Trim().
SELECT stuff(@vProcura, 5,30,Trim(@vSubstit + space(30-len(@vSubstit))))

/*
Fun��es de texto (PARTE 5: Video 22)
	- SUBSTRING
	- TRIM
	- UPPER
	- LOWER
	- TRANSLATE
	- CASE WHEN
	- IIF
*/

---- SUBSTRING -> Retira parte de um texto/string/campo de um SQL atrav�s de uma consulta.

SELECT substring('Alessandro Trovato', 1,10) as Nome
--SELECT substring(express�o[string/campo/vari�vel], A partir desta posi��o[int],Quantidade de caracteres[int]) as Nome
-- No excel esta � a fun��o do ext.texto.
-- A partir de uma string voc� escolhe a posi��o inicial e a quantidade de caracteres que deseja mostrar.

SELECT substring(a.nome, 1,5) as Nome_parcial -- Desta forma, � possivel pegar o campo nome da minha tabela Alunos e a partir da primeira posi��o extrair 5 caracteres.
FROM Alunos a

---- CASE/WHEN(enquanto/ent�o)

-- Vamos extrair os 2 primeiros nomes do nosso banco de dados:
/*
Vamos come�ar selecionando o campo nome da nossa tabela alunos. Al�m disso ser� realizada neste select uma instru��o que vai fazer a extra��o desses nomes.
Se eu der um substring do campo nome a partir da primeira posi��o e pedir para que ele extraia 20 elementos vamos ter basicamente o select que fizemos anteriormente:

SELECT a.nome, substring(a.nome,1,20)
FROM Alunos a

Para que eu possa identificar os espa�os ser� preciso substituir o 20 pela posi��o a partir da procura do segundo espa�o. Ser� necess�rio utilizar um comando que diga aonde come�a o segundo espa�o da string. Utilizando a fun��o charindex().
O charindex() precisa de uma express�o para procurar, vamos procurar o espa�o ' ', no campo a.nome. O terceiro argumento mostra a partir de que posi��o deseja-se procurar o espa�o. Se colocar o n�mero um ele procurar� a partir da primeira posi��o, mas n�o queremos que ele procure a partir da primeira posi��o e sim a partir da segunda ocorr�ncia do espa�o, por isso, substituiremos o terceiro argumento por outra instru��o charindex() para que ele possa pesquisar novamente o espa�o no campo nome, mas dessa vez colocar� +1 no retorno.
A posi��o inicial onde ele vai pesquisar essa string vai ser uma posi��o a frente de onde ele j� encontrou.

SELECT a.nome, substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
FROM Alunos a

Nesse ponto ele touxe alguns nomes, mas h� um problema para pessoas que s� tem 2 nomes, por isso, que teremos que colocar o case para fazer esse tratamento, utilizando como condi��o o substring acima.
Quando tudo isso for igual a nada ' ' (eu n�o posso colocar null porque n�o apareceu null, mas sim nada) ele vai repetir o nome porque o nome tem menos de 2 espa�os na string. Ent�o, ficar� assim, por enquanto, 

SELECT a.nome, 
	   case substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
			when ' ' then
				a.nome
FROM Alunos a

Eu ainda possi dizer se n�o. Se ele n�o tem s� dois nomes ele tem que utilizar o comando da substring.
Quando concluirmos o case daremos um end e um nome ao campo.
*/
SELECT a.nome, 
	   case substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
			when ' ' then
				a.nome
			else 
				substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
	   end as Nome_extraido
FROM Alunos a

-- Caso a substring for igual a ' ', indicando que s� contem um espa�o, ou seja, s� contem 2 nomes, ser� extraido o nome que se encontra no campo, caso contrario ser� utilizado o comando que se encontra no comando substring.

---- IIF(se) -> � como um teste logico da query.

SELECT a.nome, 
	   iif(substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) =' ', 
		   a.nome,
		   substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1))) 
FROM Alunos a

-- Se a instru��o for igual a ' ' retorne o nome que se encontra no campo a.nome, caso contrario, retorne o resultado da instru��o(substring).

---- TRANSLATE -> faz a substitui��o de caracteres.

SELECT translate('2*[3+4]/{7-2}', '[]{}','()()') 
-- tranlate(string, caracteres que se deseja substituir, caracteres que ficar�o no lugar dos que ser�o substituidos)
-- tranlate(string, Quais s�o os caractres que voc� deseja sunbstituir? , Voc� quer substituir pelo qu�? )
SELECT translate('abcdefghi', 'abc','123') 

---- REPLACE
declare @vOperacao varchar(13)
	set @vOperacao = '2*[3+4]/{7-2}'

SELECT replace('Alessandro','s','x') -- Substitui s por x na string 'Alessandro'
-- Para realizar o que foi feito anteriormente com o translate � necess�rio fazer um replace aninhado:

SELECT replace(
			replace(
				replace(
					replace(@vOperacao, '[','('),
				']',')'),
			'{','('),
		'}',')')

-- A diferen�a entre o translate e replace � que o translate substitui de forma simultanea j� o replace vai de um a um.

----TRIM -> Elimina espa�os em branco antes e depois da string.

SELECT trim('Alessandro Trovato                 ')
SELECT trim('                 Alessandro Trovato')
SELECT trim('       Alessandro Trovato          ')
SELECT trim('      Alessandro       Trovato     ') -- N�o elimina o espa�o entre os nomes.

-- Para eliminar os espa�os que encontramos no meio utilizamos:
---- WHILE(enquanto)

declare @vString varchar(100)
	set @vString = 'SQL               SERVER               '

while charindex('  ', @vString) >0
	begin
		set @vString = replace(@vString, '  ', ' ')
	end
SELECT @vString 
/*
 Enquanto a fun��o charindex localizar 2 espa�os '  ' na minha vari�vel @vString for maior do que zero, ou seja, a posi��o encontrada por maior que zero, ent�o, vamos utilizr o begin para iniciar o processo e o end para finaliz�-lo.
 Entre o begin e o end inicializaremos novamente a nossa vari�vel, sendo que agora ela ser� igual ao replace da vaiavel @vString, onde substituir� dois espa�os por um.
 Quando a fun��o while come�ar a executar ele vai analisar. Ele vai ssetar a variavel fazendo o replace checando se tem 2 caracteres de espa�os e trocando por um, depois ele verifica novamente a condi��o, at� que a condi��o n�o seja mais atendida, ou seja, n�o seja mais true.
 Ap�s parar vamos verificar a execu��o do processo com o select.
*/

---- UPPER/LOWER 
SELECT nome, upper(nome) as Maiusculo, lower(nome) as Minusculo
FROM Alunos