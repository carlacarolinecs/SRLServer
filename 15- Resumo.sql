-- Resumo -> Funções de texto:

/*
- ASCII -> A função ASCII pede uma expressão do tipo varchar com apenas um caracter. Se você tentar identificar o código ASCII de uma frase ou mais de um caracter. A função fará a identificação apenas do 1° caracter.
		-- Retorna o códico ASCII equivalente aquele caracter. Ex.: SELECT ascii(caracter do tipo varchar entre aspas)

- NCHAR -> Converte um código ASCII do tipo int em um valor de caracter. A função NCHAR é o inverso da função ASCII.
		-- Neste caso a função NCHAR pede um código da tabela de ASCII e retorna um caracter do tipo varchar.
		-- Ex.: SELECT nchar(código da tabela de ASCII) => SELECT nchar(97) -- Resultado a

- CHAR -> Se esquecer a anterior pode utilizar essa. Essa função converte um código ASCII do tipo int em um valor de caracter. Além disso, a função CHAR é o inverso da função ASCII.
			-- Ex.: SELECT char(código da tabela de ASCII) => SELECT char(97) -- Resultado a

- CHARINDEX -> Pesquisa um caracter em uma sequencia de 8000 caracteres. O primeiro argumento desta função é o caracter que se deseja encontrar no segundo argumento.
			-- Também é possivel pesquisar a partir de uma determinada posição.  Retorna a posição do caracter ou string dentro da string ou texto.
			-- Ex.: SELECT charindex( O que se quer encontrar [caracter ou string], Onde se quer encontrar [string / texto / campo / variável], a partir desta posição [inteiro]) => SELECT charindex('a', 'Trovato', 6)

- CONCAT -> Essa função concatena valores/ campos/ string.
		 -- Ex.: SELECT concat('Alessandro',' ', 'Trovato')

- CONCAT_WS -> Permite concatenar varios campos/strings utilizando um separador e ela faz isso separadamente sem que seja necessário posicionar o separador entre cada campo.
			-- O 1° argumento desta função é o separador, após isso é possivel inserir varias expressões para ela realizar a função.
			-- Ex.: SELECT concat_WS('-', 'Carla', 'Caroline', 'Carvalho', 'Silva')
			
- DIFFERENCE -> Essa função utiliza um escala de 0 a 4,
			 -- Onde 0 = Não há similaridade alguma entre as strings e 4 = Há muita similaridade entre as strings.
			 -- Ex.: SELECT difference('Alessandro', 'Alexsandro') -- Resultado = 4

- FORMAT -> Retorna um valor formatado e a cultura opcional(especificar)
		 -- Para os dados dos tipos gerais usar CAST ou CONVERT. Ex.: SELECT convert(char, getdate(), 103) -- dd/mm/yyyy
		 -- Também é possivel utilizar campos.
		 -- Ex.: SELECT format(at.valor, 'N', 'en-US') as Formato_Americano, format(at.valor, 'G', 'en-US') as Formato_Geral, format(at.valor, 'C', 'pt-BR') as Formato_Monetario_BR FROM AlunosxTurmas at

- LEFT -> Extrai caracteres a esquerda de um texto ou campos.
	   -- Ex.: SELECT left(campo ou string, quantidade de caracteres mostrados[à esquerda]) => SELECT left('Alessandro Trovato',10) -- Pede para mostrar os 10 primeiros caracteres.

- RIGHT -> Extrai caracteres a direita de um texto ou campos.
		-- Ex.: SELECT right(campo ou string, quantidade de caracteres mostrados[à direita]) => SELECT right('Alessandro Trovato',7) -- Pede para mostrar os 7 ultimos caracteres.

- LEN -> Retorna o tamanho do campo.
	  -- Essa função só retorna um argumento. Ela retorna o total de caracteres que se encontra nele.
	  -- Ex.: SELECT len(string ou campo)
	  
- LOWER -> Converte os caracteres para minusculo.
		-- Todos os nomes são convertidos para letras minusculo. Ex.: SELECT lower('ALESSANDRO TROVATO') 

- UPPER -> Converte os caracteres para maiusculo.
		-- Todos os nomes são convertidos para letras maiusculas. Ex.: SELECT upper('Alessandro Trovato')
		-- Ex.: SELECT nome, upper(nome) as Maiusculo, lower(nome) as Minusculo FROM Alunos

- LTRIM -> Serve para retirar espaços a esquerda. ( L de left)
		-- Essa função possui apenas um argumento. Ela precisa apenas da expressão do tipo nvarchar.
		-- Ex.: SELECT ltrim('                 Alessandro Trovato')

- RTRIM -> Serve para retirar espaços a direita. ( L de right)
		-- Essa função possui apenas um argumento. Ela precisa apenas da expressão do tipo nvarchar.
		-- Ex.: SELECT rtrim('Alessandro Trovato                 ')

- PATINDEX -> Retorna a posição inicial da primeira ocorrência de um padrão.
		   -- Esse controle (%  %) indica que a busca do termo tro vai ocorrer não importa se está no começo, no meio ou no fim.
		   -- Quando você utiliza o percentual entre strings significa que  esse texto que está no meio pode estar em qualquer posição em nosso texto. Isso é ótimo para fazer buscas de textos em strings grandes.
		   -- Retornará o número 12. Doze indica que a palavra tro ou a expressão que ele está procurando começa na posição 12. 
		   -- Ex.: SELECT patindex('%tro%', 'Alessandro Trovato') 

- SUBSTRING -> Extrai um texto a partir de uma posição especifica.
			-- Ex.: SELECT substring(expressão[string/ variável/ campo],A partir desta posição[int],Quantidade de caracteres a ser mostrado[int]) => SELECT substring('Aqui é o canal do Alessandro Trovato',30,7) 
			-- Ex.: SELECT substring('Alessandro Trovato', patindex('%Trovato%', 'Alessandro Trovato'), 7) O comando patindex nesta query mostra a posição em que se encontra o nome Trovato, resultando em um número inteiro.
			-- Ex.: SELECT substring('Alessandro Trovato', 1,10) as Nome
			-- Ex.: SELECT substring(a.nome, 1,5) as Nome_parcial FROM Alunos a

- REPLACE -> Substitui caracteres em um campo.
		  -- Ex.: SELECT replace(expressão[string/ variável/ campo/ texto], caracter que se deseja substituir entre aspas, caracter que ficará no lugar entre aspas) => SELECT replace('Alessandro Trovato', 'a', 'x') -- Na expressão (string) será substituido o 'a' pelo 'x'.
		  --  Ex. de replace aninhado: SELECT replace(replace('Alessandro Trovato', 'a', 'x'), 'o', '?') -- Como o primeiro argumento é uma expressão podemos utilizar o texto retornado da função replace utilizado anteriormente.

- REPLICATE -> Replica o que está no primeiro argumento o número de vezes que eu definir no segundo argumento.
			-- Ex.: SELECT replicate(O que será repetido[caracter/ string] entre aspas, quantidade de vezes[int]) -- Replica a letra x vinte vezes. => SELECT replicate('x', 20) -- Replica a letra x vinte vezes.

- REVERSE -> Inverte os caracteres da string.
		  --  Ex.: SELECT reverse(O que se deseja inverter[string/campo/texto]) => SELECT reverse('Alessandro Trovato')

- STRING_AGG -> Concatena os valores das expressões de cadeias de caracteres e coloca os valores do separador entre eles.
			 -- O separador não é adicionado ao final da cadeia de caracteres.
			 -- Seria o mesmo equivalente a função unir texto do excel.
			 -- Os valores nulls não são exibidos.
			 -- Ex.: SELECT string_agg(convert(nvarchar(max), sexo), ',') as Registro FROM Alunos -- Gerou um único registro com todos os sexos da tabela separados por virgula.
			 -- A string_agg consegue retornar nulos desde que ocorra a substituição desses nulos por algum outro caracter.
			 -- Ex.: SELECT string_agg(convert(nvarchar(max), isnull(sexo, 'N')), '-') as Registro FROM Alunos -- isnull(sexo, 'N') -> Substitui o sexo que era Null por N.

- SPACE -> Gera uma string ou um conjunto de espaços a partir de uma instrução.
		-- Ex.: SELECT 'Alessandro' + space(25) --  Concatenará o nome com 25 espaços.

- STUFF -> Substitui uma string de caracter a partir de uma posição pré determinada.
		-- Ex.: SELECT stuff(expressão[string/ campo/ texto], A partir desta posição[int] ,Quantidade de caracteres a ser substituidos[int], '12345') => SELECT stuff('abcdefghi', 3,5, '12345') -- Estou informando a função stuff que 5 caracteres desta string 'abcdefghi' será substituida por '12345' a partir da quinta posição.

- TRIM -> Elimina espaços em branco antes e depois da string.
	   -- Ex.: SELECT trim('Alessandro Trovato                 ')
	   -- Ex.: SELECT trim('                 Alessandro Trovato')
	   -- Ex.: SELECT trim('      Alessandro       Trovato     ') -- Não elimina o espaço entre os nomes.

- TRANSLATE -> faz a substituição de caracteres.
			-- tranlate(string, caracteres que se deseja substituir, caracteres que ficarão no lugar dos que serão substituidos)
			-- tranlate(string, Quais são os caractres que você deseja sunbstituir? , Você quer substituir pelo quê? )
			-- Ex.: SELECT translate('2*[3+4]/{7-2}', '[]{}','()()') 
			-- Ex.: SELECT translate('abcdefghi', 'abc','123') 

- CASE/WHEN(enquanto/então)
			-- Caso a substring for igual a ' ', indicando que só contem um espaço, ou seja, só contem 2 nomes, será extraido o nome que se encontra no campo, caso contrario será utilizado o comando que se encontra no comando substring.

			SELECT a.nome, 
				   case substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
						when ' ' then
							a.nome
					    else 
				            substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
				   end as Nome_extraido
			FROM Alunos a


- IIF(se) -> é como um teste logico da query.
		  -- Se a instrução for igual a ' ' retorne o nome que se encontra no campo a.nome, caso contrario, retorne o resultado da instrução(substring).
		  SELECT a.nome, 
				 iif(substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) =' ', 
					 a.nome,
					 substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1))) 
		  FROM Alunos a

- WHILE(enquanto)
				 Enquanto a função charindex localizar 2 espaços '  ' na minha variável @vString for maior do que zero, ou seja, a posição encontrada por maior que zero, então, vamos utilizr o begin para iniciar o processo e o end para finalizá-lo.
				 Entre o begin e o end inicializaremos novamente a nossa variável, sendo que agora ela será igual ao replace da vaiavel @vString, onde substituirá dois espaços por um.
				 Quando a função while começar a executar ele vai analisar. Ele vai ssetar a variavel fazendo o replace checando se tem 2 caracteres de espaços e trocando por um, depois ele verifica novamente a condição, até que a condição não seja mais atendida, ou seja, não seja mais true.
				 Após parar vamos verificar a execução do processo com o select.
			
				 declare @vString varchar(100)
					 set @vString = 'SQL               SERVER               '

				 while charindex('  ', @vString) >0
					begin
						set @vString = replace(@vString, '  ', ' ')
					end
				 SELECT @vString 


*/