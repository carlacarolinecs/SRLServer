/*
Funções de texto (PARTE 1: Video 17)

São funções que normalmente vamos utilizar para fazer comparações ou para identificar conjuntos de caracteres 
ou o número do caracter na tabela ASCII:

- ASCII
- NCHAR
- CHAR
- CHARINDEX
- CONCAT
- CONCAT_WS
- DIFFERENCE

*/

---- ASCII
-- A função ASCII pede uma expressão do tipo varchar com apenas um caracter.

SELECT ascii('a') -- Na tabela de códigos ASCII o a minusculo equivale ao número 97.
SELECT ascii('A') -- Na tabela de códigos ASCII o A maiusculo equivale ao número 65.
SELECT ascii('9') -- Na tabela de códigos ASCII o número 9 equivale ao número 57.

-- Se você tentar identificar o código ASCII de uma frase ou mais de um caracter. A função fará a identificação apenas do 1° caracter.
SELECT ascii('Alessandro') -- Resultado 65

---- NCHAR -> Converte um código ASCII do tipo int em um valor de caracter.
-- A função NCHAR é o inverso da função ASCII

SELECT nchar(97) -- Resultado a
SELECT nchar(65) -- Resultado A
SELECT nchar(57) -- Resultado 9

---- CHAR -> Se esquecer a anterior pode utilizar essa.
-- Converte um código ASCII do tipo int em um valor de caracter. Além disso, a função CHAR é o inverso da função ASCII.

SELECT char(97) -- Resultado a
SELECT char(65) -- Resultado A
SELECT char(57) -- Resultado 9

---- CHARINDEX  -> Pesquisa um caracter em uma sequencia de 8000 caracteres.
-- O primeiro argumento desta função é o caracter que se deseja encontrar no segundo argumento.

SELECT charindex('a', 'Trovato') -- Resultado = 5

-- Essa função retorna o index, ou seja, a posição do caracter que se encontra no primeiro argumento, dentro do segundo argumento, contando a partir do terceiro argumento.
SELECT charindex('a', 'Trovato', 6) -- Também é possivel pesquisar a partir de uma determinada posição; Resultado = 0.

-- Deseja-se pesquisar uma palavra dentro de uma string completa, a partir da posição número 1.
-- O padrão começa por um, então não faz diferença colocar ou não.
SELECT charindex('carvalho', 'carla caroline carvalho silva', 1)

--Essa função também pode ser utilizada se você deseja procurar textos em campos ou tabelas.
SELECT * FROM Alunos
SELECT a.nome, charindex('Prado', a.nome,1) FROM Alunos a -- Para encontrar o sobrenome Prado em uma coluna da tabela Alunos

-- Para mostrar apenas aqueles que tem o sobrenome Prado utiliza-se o WHERE:
SELECT a.nome, charindex('Prado', a.nome,1) 
FROM Alunos a 
WHERE convert(int, charindex('Prado',a.nome, 1))>0 --Precia converter para inteiro para depois colocar o resultado em uma condição.

--ou

SELECT a.nome, charindex('Prado', a.nome,1) 
FROM Alunos a 
WHERE  charindex('Prado',a.nome, 1)<>'0'

---- CONCAT -> Essa função concatena valores

SELECT concat('Alessandro',' ', 'Trovato')
SELECT concat('Alessandro',' || ', 'Trovato')

-- Também é possivel concatenar sem a função:
SELECT 'Alessandro' + ' ' +  'Trovato' 

-- Podemos utilizr a função dentro das nossas querys de BD:
SELECT concat(a.nome,' - ', c.curso) as "Nome do aluno - Curso"
FROM Alunos a
	inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso

---- CONCAT_WS -> Permite concatenar varios campos utilizando um separador e ela faz isso separadamente sem que seja necessário posicionar o separador entre cada campo.

SELECT concat_WS('-', 'Carla', 'Caroline', 'Carvalho', 'Silva')

-- O 1° argumento desta função é o separador, após isso é possivel inserir varias expressões para ela realizar a função.
-- Também é possivel fazer isso utilizando o nosso BD:
SELECT concat_WS('-', a.nome, c.curso,
				 'Início: '+ convert(char, t.data_inicio),
				 'Termino: '+ convert(char, t.data_termino)) 
FROM Alunos a
	inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso

-- Para eliminar os espaçamentos adicionais utilize o trim() antes da converção.
SELECT concat_WS('-', a.nome, c.curso,
				 'Início: '+ trim(convert(char, t.data_inicio)),
				 'Termino: '+ trim(convert(char, t.data_termino))) 
FROM Alunos a
	inner join AlunosxTurmas at on at.id_aluno = a.id_aluno
	inner join Turmas t on t.id_turma = at.id_turma
	inner join Cursos c on c.id_curso = t.id_curso

---- DIFFERENCE -> Essa função utiliza um escala de 0 a 4,
				-- Onde 0 = Não há similaridade alguma entre as strings e 4 = Há muita similaridade entre as strings.

SELECT difference('Alessandro', 'Alexsandro') -- Resultado = 4
SELECT difference('Alessandro', 'Alex') -- Resultado = 3
SELECT difference('Alessandro', 'Sandro') -- Resultado = 1
SELECT difference('Alessandro', 'Excel') -- Resultado = 1
SELECT difference('Alessandro', 'Youtube') -- Resultado = 0

/*
Funções de texto (PARTE 2: Video 18)
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

-- Também é possivel utilizar variavel em nossos selects:
/*
DECLARE @dt DATETIME = convert(char, getdate(), 103)
SELECT @dt  

	Se retirar de comentario mostrará um erro na declaração seguinte(ondinhas em baixo da declaração),
	mas não é um erro, apenas mostra isso devido ao fato de a variável já haver sido declarada anteriormente.
*/

/*
DECLARE @dt DATETIME = getdate()
SELECT format(@dt, 'd', 'en-US') as Americano,
	   format(@dt, 'd', 'zh-cn') as Chines_Simplificado,
	   format(@dt, 'd', 'de-de') as "Alemão",
	   format(@dt, 'D', 'en-US') as Americano, -- D maiusculo deixa por extenso
	   format(@dt, 'D', 'zh-cn') as Chines_Simplificado, -- D maiusculo deixa por extenso
	   format(@dt, 'D', 'de-de') as "Alemão" -- D maiusculo deixa por extenso
*/

DECLARE @dt DATETIME = getdate()
SELECT format(1001500, '##-####-##') as cod_prod

--Também é possivel utilizar a função em nosso banco de dados
-- Quero formatar o campo at.valor do tipo numerico, no padrão americano.

SELECT format(at.valor, 'N', 'en-US') as Formato_Americano,
	   format(at.valor, 'G', 'en-US') as Formato_Geral,
	   format(at.valor, 'C', 'pt-BR') as Formato_Monetario_BR,
	   format(at.valor, 'C', 'en-US') as Formato_Monetario_US,
	   format(at.valor, 'C', 'de-de') as Formato_Monetario_AL,
	   format(at.valor, 'C', 'de-at') as Formato_Monetario_AUS
FROM AlunosxTurmas at

---- LEFT -> Extrai caracteres a esquerda de um texto ou campos.

SELECT left('Alessandro Trovato',10) -- Pede para mostrar os 10 primeiros caracteres.
SELECT left('Este é um curso de SQL',18) -- Pede para mostrar os 18 primeiros caracteres.

-- Utilizando campos do BD:
SELECT distinct left(a.nome, 5)
FROM Alunos a

---- RIGHT -> Extrai caracteres a direita de um texto ou campos.
SELECT right('Alessandro Trovato',7) -- Pede para mostrar os 7 ultimos caracteres.
SELECT right('Este é um curso de SQL',12) -- Pede para mostrar os 12 ultimos caracteres.

-- Utilizando campos do BD:
SELECT distinct right(a.nome, 5)
FROM Alunos a

-- Além disso, é possivel concatenar o left e o right:
SELECT left(a.nome, 5) + right(a.nome, 5)
FROM Alunos a

---- LEN -> Retorna o tamanho do campo
		 -- Essa função só retorna um argumento. Ela retorna o total de caracteres que se encontra nele.

SELECT len('Alessandro Trovato') 
SELECT len('Este é um curso de SQL')

-- Também é possivel verificar o tamanho dos campos:

SELECT a.nome, len(a.nome) as Tamanho
FROM Alunos a
SELECT a.nome, max(len(a.nome)) as Tamanho
FROM Alunos a
SELECT a.nome, min(len(a.nome)) as Tamanho
FROM Alunos a

---- UPPER -> Converte os caracteres para maiusculo.
		   -- Todos os nomes são convertidos para letras maiusculas.

SELECT upper('Alessandro Trovato') 

-- Também é possivel utilizar a função em BD.
SELECT upper(a.nome) as Nome_Alunos
FROM Alunos a		 

---- LOWER -> Converte os caracteres para minusculo.
		   -- Todos os nomes são convertidos para letras minusculo.

SELECT lower('ALESSANDRO TROVATO') 

-- Também é possivel utilizar a função em BD.
SELECT lower(a.nome) as Nome_Alunos
FROM Alunos a	

/*
Funções de texto (PARTE 3: Video 19)
	- LTRIM - Serve para retirar espaços a esquerda. ( L de left)
	- RTRIM - Serve para retirar espaços extras a direita de uma string. (R de right)
	- PATINDEX
	- REPLACE
	- REPLICATE
	- REVERSE
*/

---- LTRIM -> Serve para retirar espaços a esquerda. ( L de left)
		   -- Essa função possui apenas um argumento. Ela precisa apenas da expressão nvarchar.

SELECT ltrim('                 Alessandro Trovato')
SELECT ltrim('x	               Alessandro Trovato')  -- Se houver qualquer caracter antes desses espaços o espaço não será eliminado. Essa função apenas remove espaços livres a esquerda, não entre palavras.

-- Utilizando o conceito de variável:
declare @varTexto varchar(50) -- Declarando uma variavel chamada varTexto que será do tipo varchar com 50 posições.
	set @varTexto = '             Este é um texto para teste no LTRIM.' -- O comando set vai fazer com que a variavel seja inicializada.

SELECT ltrim(@varTexto)as teste;

-- Outra forma de fazer isso é(mudei o nome apenas para evitar o erro, pois a variavel vartexto já foi declarada anteriormente:
declare @varstring varchar(50) -- Declarando uma variavel chamada varstring que será do tipo varchar com 50 posições.
	set @varstring = '            Este é um texto para teste no LTRIM.' -- O comando set vai fazer com que a variavel seja inicializada.

SELECT Resultado = ltrim(@varstring)
 
---- RTRIM -> Serve para retirar espaços a direita. ( L de right)
		   -- Essa função possui apenas um argumento. Ela precisa apenas da expressão nvarchar.

SELECT rtrim('Alessandro Trovato                 ')
SELECT rtrim('Alessandro Trovato                x')  -- Se houver qualquer caracter após esses espaços o espaço não será eliminado. Essa função apenas remove espaços livres a direita, não entre palavras.

SELECT len(rtrim('Alessandro Trovato                 ')) -- Ao utilizar a função len() é possivel verificar a quantidade de caracteres, contudo, como a função len() desconsidera os espaços livres a direita, a quantidade de caracteres é a mesma de quando não utiliza-se o RTRIM. Observe:
SELECT len('Alessandro Trovato                 ')

SELECT len(rtrim('Alessandro Trovato                x')) -- Se houver qualquer caracter após esses espaços, os (caracteres referentes aos) espaços serão contados. Observe:
SELECT len('Alessandro Trovato                x')

-- Utilizando o conceito de variável:
declare @varText varchar(50) -- Declarando uma variavel chamada varText que será do tipo varchar com 50 posições.
	set @varText = 'Este é um texto para teste no RTRIM.                 ' -- O comando set vai fazer com que a variavel seja inicializada.

SELECT rtrim(@varText)

---- PATINDEX -> Retorna a posição inicial da primeira ocorrência de um padrão.

SELECT patindex('%tro%', 'Alessandro Trovato') -- Esse controle (%  %) indica que a busca do termo tro vai ocorrer não importa se está no começo, no meio ou no fim.
-- Quando você utiliza o percentual entre strings significa que  esse texto que está no meio pode estar em qualquer posição em nosso texto. Isso é ótimo para fazer buscas de textos em strings grandes.
-- Retornará o número 12. Doze indica que a palavra tro ou a expressão que ele está procurando começa´na posição 12. 

-- Outro exemplo:
SELECT patindex('%a', 'Terça'); -- Resultado 5
-- A query acima mostra a posição da letra 'a' dentro da string ou palavra que termine com a letra a.
SELECT patindex('%a', 'Sabado'); -- Resultado 0 porque a palavra sabado não termina com a.
SELECT patindex('%a', 'A vião sem asa, fogueira sem brasa') -- Resultado 34

-- Também é possivel utilizar o percentual em outra posição.
SELECT patindex('a%', 'Trovato') -- Procura a letra a no começo da string ou em qualquer outra posição que começa com a letra a.
SELECT patindex('a%', 'Alessandro')-- Se trocar Alessandro por trovato você encontrará a posição número 1.

-- Também é possivel nomear a query da seguinte forma:
SELECT posicao=patindex('%At%', 'Alessandro Trovato') -- Independente se colocar At ou at irá resultar no número 16.
SELECT posicao=patindex('%dro_Trov%', 'Alessandro Trovato')-- Tem que colocar os percentuais se não resultará em zero.

---- SUBSTRING -> Extrai um texto a partir de uma posição especifica.
SELECT substring('Aqui é o canal do Alessandro Trovato',30,7) 

-- Utilizando variável:
declare @varTexto3 varchar(100)  -- Declarando uma variável chamada varTexto3. Ela vai ser do tipo varchar de 100 posições.
	set @varTexto3 = 'Aqui é o canal do Alessandro Trovato no Youtube.' -- Nós vamos iniciar a nossa variável que vai ser igual ao texto entre aspas.
SELECT substring(@varTexto3, 1, 7) -- Mostrar a partir da posição 1 com 7 caracteres mostrados.

-- A query acima resultará em "Aqui é". Os 7 primeiros caracteres, mas não é isso que queremos, por isso, substituiremos o número por patindex(). Observe:
SELECT substring(@varTexto3, patindex('%Trovato%', @varTexto3), 7) -- Deseja-se encontrar o nome Trovato dentro da variável @varTexto3
-- O comando patindex() é utilizado na query anterior para mostrar a posição em que se encontra o nome Trovato, então, a partir desta posição mostrará 7 caracteres.
-- patindex('%Trovato%', @varTexto3) -- Resultará na posição 30.

---- REPLACE -> Substitui caracteres em um campo.

SELECT replace('Alessandro Trovato', 'a', 'x') -- Na expressão (string) será substituido o 'a' pelo 'x'.

-- Também é possivel fazer a substituição de forma aninhada.
SELECT replace(replace('Alessandro Trovato', 'a', 'x'), 'o', '?') -- Como o primeiro argumento é uma expressão podemos utilizar o texto retornado da função replace utilizado anteriormente.

-- Vamos utilizar o nosso banco de dados:
SELECT a.nome, a.data_nascimento, a.sexo
FROM Alunos a
-- Vamos fazer o replace no campo sexo:
SELECT a.nome, a.data_nascimento, replace(a.sexo, 'M', 'Masculino') as sexo -- Demos um replace no campo sexo, mas não foi possivel fazer um replace no F, se eu colocar essa função encadeada em outro replace não dará certo.
FROM Alunos a 

-- Um exemplo bem tipico da função replace é para os campos de CPF em BD. 
-- Utilizando variáveis:
declare @cpf varchar(15);
	set @cpf = '111.111.111-11';
SELECT replace(@cpf, '.', ' ') -- Tirando pontos
SELECT replace(@cpf, '-', ' ') -- tirando hífen
SELECT replace(replace(@cpf, '-', ' '), '-', ' ') -- Tirando os 2 ao mesmo tempo.

---- REPLICATE -> Replica o que está no primeiro argumento o número de vezes que eu definir no segundo argumento.

SELECT replicate('x', 20) -- Replica a letra x vinte vezes.

-- Também é possivel fazer com que todos os nomes tenham um tamanho fixo de coluna.
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
Funções de texto (PARTE 4: Video 20)
	- STRING_AGG
	- SPACE
	- STUFF
*/

---- SPACE -> Gera uma string ou um conjunto de espaços a partir de uma instrução.

SELECT 'Alessandro' + space(25) --  Concatenará o nome com 25 espaços.
SELECT 'Alessandro' + space(25)+ 'x' -- Para visualizar os espaços podemos colocar a letra 'x' no final.

-- Utilizando variáveis:
declare @vnome varchar(50); -- Declarando uma variável chamada vnome, do tipo varchar com 50 posições.
	set @vnome = 'Alessandro Trovato' -- Nós vamos iniciar a variável(vnome) que vai ser igual a string 'Alessandro Trovato'.
SELECT @vnome + space(50-len(@vnome)) -- space(50-len(@vnome)) -> Espaços proporcionais a 50 desde que subtraia o tamanho do nome da minha variável.

-- Se ao onvés da variável colocassemos o nome de um campo pertencente a um banco de dados, subtrairia o tamanho dos elementos deste capo de tamanho fixo.
SELECT a.nome + space(60-len(a.nome)) + a.sexo -- Irá colocar o campo sexo para verificar como ficará o espaço.
FROM Alunos a

SELECT a.nome + space(60-len(a.nome)) + a.sexo,
	   len(a.nome + space(60 -len(a.nome))+a.sexo) -- Para mostrar o tamanho.
FROM Alunos a
-- Porque o resultado da query acima tem tamanho de 61 caracteres? R= Esse caracter adicional foi dado pelo caracter de sexo.

---- STRING_AGG -> Concatena os valores das expressões de cadeias de caracteres e coloca os valores do separador entre eles.
				-- O separador não é adicionado ao final da cadeia de caracteres.
				-- Seria o mesmo equivalente a função unir texto do excel.
				-- Os valores nulls não são exibidos.

SELECT string_agg(convert(nvarchar(max), sexo), ',') as Registro -- Gerou um único registro com todos os sexos da tabela separados por virgula.
FROM Alunos 

-- Substitua o que for Null por N para aparecer.
SELECT string_agg(convert(nvarchar(max), isnull(sexo, 'N')), '-') as Registro -- isnull(sexo, 'N') -> Substitui o sexo que era Null por N.
FROM Alunos

-- A string_agg consegue retornar nulos desde que ocorra a substituição desses nulos por algum outro caracter.
SELECT datepart(year, data_nascimento) ano, 
	   string_agg(convert(nvarchar(max), isnull(sexo, '0')), '-')
FROM Alunos
Group by datepart(year, data_nascimento)
Order by 1
-- A query acima mostrará os sexos agrupados conforme o ano de nascimento dos alunos, ordenados de forma crescente.

-- Outra forma de obter o mesmo resultado é utilizando o comando within:
SELECT datepart(year, data_nascimento) ano, -- Select do ano de nascimento dos alunos.
	   string_agg(convert(nvarchar(max), isnull(sexo, '0')), '-')-- Faz o agrupamento do sexo substituindo o null por 0
			within group( order by datepart(year, data_nascimento) asc) as registro
FROM Alunos
Group by datepart(year, data_nascimento) -- Agrupar por ano

---- STUFF -> Substitui uma string de caracter a partir de uma posição pré determinada.

SELECT stuff('abcdefghi', 3,5, '12345') -- Estou informando a função stuff que 5 caracteres desta string 'abcdefghi' será substituida por '12345' a partir da quinta posição.

-- Utilizando variáveis:
declare @vProcura varchar(50); -- Declarando uma variável chamada vProcura, do tipo varchar com 50 posições.
declare @vSubstit varchar(30); -- Declarando uma variável chamada vSubstit, do tipo varchar com 30 posições.
	set @vProcura = 'Eu, xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx, autorizo...' -- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -> 30 posições
	set @vSubstit = ' Alessandro Trovato' -- ' Alessandro Trovato' -> Não tem 30 posições.

-- Como o nome 'Alessandro Trovato' não possui 30 posições é preciso adicionar espaços para realizar a troca, para isso utilizamos o comando space.
SELECT stuff(@vProcura, 5,30,@vSubstit + space(30-len(@vSubstit)))

-- Contudo, em um contrato esses espaços ficariam inadequados, por isso, para tirar esses espaços podemos utilizar o comando Trim().
SELECT stuff(@vProcura, 5,30,Trim(@vSubstit + space(30-len(@vSubstit))))

/*
Funções de texto (PARTE 5: Video 22)
	- SUBSTRING
	- TRIM
	- UPPER
	- LOWER
	- TRANSLATE
	- CASE WHEN
	- IIF
*/

---- SUBSTRING -> Retira parte de um texto/string/campo de um SQL através de uma consulta.

SELECT substring('Alessandro Trovato', 1,10) as Nome
--SELECT substring(expressão[string/campo/variável], A partir desta posição[int],Quantidade de caracteres[int]) as Nome
-- No excel esta é a função do ext.texto.
-- A partir de uma string você escolhe a posição inicial e a quantidade de caracteres que deseja mostrar.

SELECT substring(a.nome, 1,5) as Nome_parcial -- Desta forma, é possivel pegar o campo nome da minha tabela Alunos e a partir da primeira posição extrair 5 caracteres.
FROM Alunos a

---- CASE/WHEN(enquanto/então)

-- Vamos extrair os 2 primeiros nomes do nosso banco de dados:
/*
Vamos começar selecionando o campo nome da nossa tabela alunos. Além disso será realizada neste select uma instrução que vai fazer a extração desses nomes.
Se eu der um substring do campo nome a partir da primeira posição e pedir para que ele extraia 20 elementos vamos ter basicamente o select que fizemos anteriormente:

SELECT a.nome, substring(a.nome,1,20)
FROM Alunos a

Para que eu possa identificar os espaços será preciso substituir o 20 pela posição a partir da procura do segundo espaço. Será necessário utilizar um comando que diga aonde começa o segundo espaço da string. Utilizando a função charindex().
O charindex() precisa de uma expressão para procurar, vamos procurar o espaço ' ', no campo a.nome. O terceiro argumento mostra a partir de que posição deseja-se procurar o espaço. Se colocar o número um ele procurará a partir da primeira posição, mas não queremos que ele procure a partir da primeira posição e sim a partir da segunda ocorrência do espaço, por isso, substituiremos o terceiro argumento por outra instrução charindex() para que ele possa pesquisar novamente o espaço no campo nome, mas dessa vez colocará +1 no retorno.
A posição inicial onde ele vai pesquisar essa string vai ser uma posição a frente de onde ele já encontrou.

SELECT a.nome, substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
FROM Alunos a

Nesse ponto ele touxe alguns nomes, mas há um problema para pessoas que só tem 2 nomes, por isso, que teremos que colocar o case para fazer esse tratamento, utilizando como condição o substring acima.
Quando tudo isso for igual a nada ' ' (eu não posso colocar null porque não apareceu null, mas sim nada) ele vai repetir o nome porque o nome tem menos de 2 espaços na string. Então, ficará assim, por enquanto, 

SELECT a.nome, 
	   case substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
			when ' ' then
				a.nome
FROM Alunos a

Eu ainda possi dizer se não. Se ele não tem só dois nomes ele tem que utilizar o comando da substring.
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

-- Caso a substring for igual a ' ', indicando que só contem um espaço, ou seja, só contem 2 nomes, será extraido o nome que se encontra no campo, caso contrario será utilizado o comando que se encontra no comando substring.

---- IIF(se) -> é como um teste logico da query.

SELECT a.nome, 
	   iif(substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) =' ', 
		   a.nome,
		   substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1))) 
FROM Alunos a

-- Se a instrução for igual a ' ' retorne o nome que se encontra no campo a.nome, caso contrario, retorne o resultado da instrução(substring).

---- TRANSLATE -> faz a substituição de caracteres.

SELECT translate('2*[3+4]/{7-2}', '[]{}','()()') 
-- tranlate(string, caracteres que se deseja substituir, caracteres que ficarão no lugar dos que serão substituidos)
-- tranlate(string, Quais são os caractres que você deseja sunbstituir? , Você quer substituir pelo quê? )
SELECT translate('abcdefghi', 'abc','123') 

---- REPLACE
declare @vOperacao varchar(13)
	set @vOperacao = '2*[3+4]/{7-2}'

SELECT replace('Alessandro','s','x') -- Substitui s por x na string 'Alessandro'
-- Para realizar o que foi feito anteriormente com o translate é necessário fazer um replace aninhado:

SELECT replace(
			replace(
				replace(
					replace(@vOperacao, '[','('),
				']',')'),
			'{','('),
		'}',')')

-- A diferença entre o translate e replace é que o translate substitui de forma simultanea já o replace vai de um a um.

----TRIM -> Elimina espaços em branco antes e depois da string.

SELECT trim('Alessandro Trovato                 ')
SELECT trim('                 Alessandro Trovato')
SELECT trim('       Alessandro Trovato          ')
SELECT trim('      Alessandro       Trovato     ') -- Não elimina o espaço entre os nomes.

-- Para eliminar os espaços que encontramos no meio utilizamos:
---- WHILE(enquanto)

declare @vString varchar(100)
	set @vString = 'SQL               SERVER               '

while charindex('  ', @vString) >0
	begin
		set @vString = replace(@vString, '  ', ' ')
	end
SELECT @vString 
/*
 Enquanto a função charindex localizar 2 espaços '  ' na minha variável @vString for maior do que zero, ou seja, a posição encontrada por maior que zero, então, vamos utilizr o begin para iniciar o processo e o end para finalizá-lo.
 Entre o begin e o end inicializaremos novamente a nossa variável, sendo que agora ela será igual ao replace da vaiavel @vString, onde substituirá dois espaços por um.
 Quando a função while começar a executar ele vai analisar. Ele vai ssetar a variavel fazendo o replace checando se tem 2 caracteres de espaços e trocando por um, depois ele verifica novamente a condição, até que a condição não seja mais atendida, ou seja, não seja mais true.
 Após parar vamos verificar a execução do processo com o select.
*/

---- UPPER/LOWER 
SELECT nome, upper(nome) as Maiusculo, lower(nome) as Minusculo
FROM Alunos