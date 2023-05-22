-- Resumo -> Fun��es de texto:

/*
- ASCII -> A fun��o ASCII pede uma express�o do tipo varchar com apenas um caracter. Se voc� tentar identificar o c�digo ASCII de uma frase ou mais de um caracter. A fun��o far� a identifica��o apenas do 1� caracter.
		-- Retorna o c�dico ASCII equivalente aquele caracter. Ex.: SELECT ascii(caracter do tipo varchar entre aspas)

- NCHAR -> Converte um c�digo ASCII do tipo int em um valor de caracter. A fun��o NCHAR � o inverso da fun��o ASCII.
		-- Neste caso a fun��o NCHAR pede um c�digo da tabela de ASCII e retorna um caracter do tipo varchar.
		-- Ex.: SELECT nchar(c�digo da tabela de ASCII) => SELECT nchar(97) -- Resultado a

- CHAR -> Se esquecer a anterior pode utilizar essa. Essa fun��o converte um c�digo ASCII do tipo int em um valor de caracter. Al�m disso, a fun��o CHAR � o inverso da fun��o ASCII.
			-- Ex.: SELECT char(c�digo da tabela de ASCII) => SELECT char(97) -- Resultado a

- CHARINDEX -> Pesquisa um caracter em uma sequencia de 8000 caracteres. O primeiro argumento desta fun��o � o caracter que se deseja encontrar no segundo argumento.
			-- Tamb�m � possivel pesquisar a partir de uma determinada posi��o.  Retorna a posi��o do caracter ou string dentro da string ou texto.
			-- Ex.: SELECT charindex( O que se quer encontrar [caracter ou string], Onde se quer encontrar [string / texto / campo / vari�vel], a partir desta posi��o [inteiro]) => SELECT charindex('a', 'Trovato', 6)

- CONCAT -> Essa fun��o concatena valores/ campos/ string.
		 -- Ex.: SELECT concat('Alessandro',' ', 'Trovato')

- CONCAT_WS -> Permite concatenar varios campos/strings utilizando um separador e ela faz isso separadamente sem que seja necess�rio posicionar o separador entre cada campo.
			-- O 1� argumento desta fun��o � o separador, ap�s isso � possivel inserir varias express�es para ela realizar a fun��o.
			-- Ex.: SELECT concat_WS('-', 'Carla', 'Caroline', 'Carvalho', 'Silva')
			
- DIFFERENCE -> Essa fun��o utiliza um escala de 0 a 4,
			 -- Onde 0 = N�o h� similaridade alguma entre as strings e 4 = H� muita similaridade entre as strings.
			 -- Ex.: SELECT difference('Alessandro', 'Alexsandro') -- Resultado = 4

- FORMAT -> Retorna um valor formatado e a cultura opcional(especificar)
		 -- Para os dados dos tipos gerais usar CAST ou CONVERT. Ex.: SELECT convert(char, getdate(), 103) -- dd/mm/yyyy
		 -- Tamb�m � possivel utilizar campos.
		 -- Ex.: SELECT format(at.valor, 'N', 'en-US') as Formato_Americano, format(at.valor, 'G', 'en-US') as Formato_Geral, format(at.valor, 'C', 'pt-BR') as Formato_Monetario_BR FROM AlunosxTurmas at

- LEFT -> Extrai caracteres a esquerda de um texto ou campos.
	   -- Ex.: SELECT left(campo ou string, quantidade de caracteres mostrados[� esquerda]) => SELECT left('Alessandro Trovato',10) -- Pede para mostrar os 10 primeiros caracteres.

- RIGHT -> Extrai caracteres a direita de um texto ou campos.
		-- Ex.: SELECT right(campo ou string, quantidade de caracteres mostrados[� direita]) => SELECT right('Alessandro Trovato',7) -- Pede para mostrar os 7 ultimos caracteres.

- LEN -> Retorna o tamanho do campo.
	  -- Essa fun��o s� retorna um argumento. Ela retorna o total de caracteres que se encontra nele.
	  -- Ex.: SELECT len(string ou campo)
	  
- LOWER -> Converte os caracteres para minusculo.
		-- Todos os nomes s�o convertidos para letras minusculo. Ex.: SELECT lower('ALESSANDRO TROVATO') 

- UPPER -> Converte os caracteres para maiusculo.
		-- Todos os nomes s�o convertidos para letras maiusculas. Ex.: SELECT upper('Alessandro Trovato')
		-- Ex.: SELECT nome, upper(nome) as Maiusculo, lower(nome) as Minusculo FROM Alunos

- LTRIM -> Serve para retirar espa�os a esquerda. ( L de left)
		-- Essa fun��o possui apenas um argumento. Ela precisa apenas da express�o do tipo nvarchar.
		-- Ex.: SELECT ltrim('                 Alessandro Trovato')

- RTRIM -> Serve para retirar espa�os a direita. ( L de right)
		-- Essa fun��o possui apenas um argumento. Ela precisa apenas da express�o do tipo nvarchar.
		-- Ex.: SELECT rtrim('Alessandro Trovato                 ')

- PATINDEX -> Retorna a posi��o inicial da primeira ocorr�ncia de um padr�o.
		   -- Esse controle (%  %) indica que a busca do termo tro vai ocorrer n�o importa se est� no come�o, no meio ou no fim.
		   -- Quando voc� utiliza o percentual entre strings significa que  esse texto que est� no meio pode estar em qualquer posi��o em nosso texto. Isso � �timo para fazer buscas de textos em strings grandes.
		   -- Retornar� o n�mero 12. Doze indica que a palavra tro ou a express�o que ele est� procurando come�a na posi��o 12. 
		   -- Ex.: SELECT patindex('%tro%', 'Alessandro Trovato') 

- SUBSTRING -> Extrai um texto a partir de uma posi��o especifica.
			-- Ex.: SELECT substring(express�o[string/ vari�vel/ campo],A partir desta posi��o[int],Quantidade de caracteres a ser mostrado[int]) => SELECT substring('Aqui � o canal do Alessandro Trovato',30,7) 
			-- Ex.: SELECT substring('Alessandro Trovato', patindex('%Trovato%', 'Alessandro Trovato'), 7) O comando patindex nesta query mostra a posi��o em que se encontra o nome Trovato, resultando em um n�mero inteiro.
			-- Ex.: SELECT substring('Alessandro Trovato', 1,10) as Nome
			-- Ex.: SELECT substring(a.nome, 1,5) as Nome_parcial FROM Alunos a

- REPLACE -> Substitui caracteres em um campo.
		  -- Ex.: SELECT replace(express�o[string/ vari�vel/ campo/ texto], caracter que se deseja substituir entre aspas, caracter que ficar� no lugar entre aspas) => SELECT replace('Alessandro Trovato', 'a', 'x') -- Na express�o (string) ser� substituido o 'a' pelo 'x'.
		  --  Ex. de replace aninhado: SELECT replace(replace('Alessandro Trovato', 'a', 'x'), 'o', '?') -- Como o primeiro argumento � uma express�o podemos utilizar o texto retornado da fun��o replace utilizado anteriormente.

- REPLICATE -> Replica o que est� no primeiro argumento o n�mero de vezes que eu definir no segundo argumento.
			-- Ex.: SELECT replicate(O que ser� repetido[caracter/ string] entre aspas, quantidade de vezes[int]) -- Replica a letra x vinte vezes. => SELECT replicate('x', 20) -- Replica a letra x vinte vezes.

- REVERSE -> Inverte os caracteres da string.
		  --  Ex.: SELECT reverse(O que se deseja inverter[string/campo/texto]) => SELECT reverse('Alessandro Trovato')

- STRING_AGG -> Concatena os valores das express�es de cadeias de caracteres e coloca os valores do separador entre eles.
			 -- O separador n�o � adicionado ao final da cadeia de caracteres.
			 -- Seria o mesmo equivalente a fun��o unir texto do excel.
			 -- Os valores nulls n�o s�o exibidos.
			 -- Ex.: SELECT string_agg(convert(nvarchar(max), sexo), ',') as Registro FROM Alunos -- Gerou um �nico registro com todos os sexos da tabela separados por virgula.
			 -- A string_agg consegue retornar nulos desde que ocorra a substitui��o desses nulos por algum outro caracter.
			 -- Ex.: SELECT string_agg(convert(nvarchar(max), isnull(sexo, 'N')), '-') as Registro FROM Alunos -- isnull(sexo, 'N') -> Substitui o sexo que era Null por N.

- SPACE -> Gera uma string ou um conjunto de espa�os a partir de uma instru��o.
		-- Ex.: SELECT 'Alessandro' + space(25) --  Concatenar� o nome com 25 espa�os.

- STUFF -> Substitui uma string de caracter a partir de uma posi��o pr� determinada.
		-- Ex.: SELECT stuff(express�o[string/ campo/ texto], A partir desta posi��o[int] ,Quantidade de caracteres a ser substituidos[int], '12345') => SELECT stuff('abcdefghi', 3,5, '12345') -- Estou informando a fun��o stuff que 5 caracteres desta string 'abcdefghi' ser� substituida por '12345' a partir da quinta posi��o.

- TRIM -> Elimina espa�os em branco antes e depois da string.
	   -- Ex.: SELECT trim('Alessandro Trovato                 ')
	   -- Ex.: SELECT trim('                 Alessandro Trovato')
	   -- Ex.: SELECT trim('      Alessandro       Trovato     ') -- N�o elimina o espa�o entre os nomes.

- TRANSLATE -> faz a substitui��o de caracteres.
			-- tranlate(string, caracteres que se deseja substituir, caracteres que ficar�o no lugar dos que ser�o substituidos)
			-- tranlate(string, Quais s�o os caractres que voc� deseja sunbstituir? , Voc� quer substituir pelo qu�? )
			-- Ex.: SELECT translate('2*[3+4]/{7-2}', '[]{}','()()') 
			-- Ex.: SELECT translate('abcdefghi', 'abc','123') 

- CASE/WHEN(enquanto/ent�o)
			-- Caso a substring for igual a ' ', indicando que s� contem um espa�o, ou seja, s� contem 2 nomes, ser� extraido o nome que se encontra no campo, caso contrario ser� utilizado o comando que se encontra no comando substring.

			SELECT a.nome, 
				   case substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
						when ' ' then
							a.nome
					    else 
				            substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) 
				   end as Nome_extraido
			FROM Alunos a


- IIF(se) -> � como um teste logico da query.
		  -- Se a instru��o for igual a ' ' retorne o nome que se encontra no campo a.nome, caso contrario, retorne o resultado da instru��o(substring).
		  SELECT a.nome, 
				 iif(substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1)) =' ', 
					 a.nome,
					 substring(a.nome, 1, charindex(' ',a.nome, charindex(' ', a.nome)+1))) 
		  FROM Alunos a

- WHILE(enquanto)
				 Enquanto a fun��o charindex localizar 2 espa�os '  ' na minha vari�vel @vString for maior do que zero, ou seja, a posi��o encontrada por maior que zero, ent�o, vamos utilizr o begin para iniciar o processo e o end para finaliz�-lo.
				 Entre o begin e o end inicializaremos novamente a nossa vari�vel, sendo que agora ela ser� igual ao replace da vaiavel @vString, onde substituir� dois espa�os por um.
				 Quando a fun��o while come�ar a executar ele vai analisar. Ele vai ssetar a variavel fazendo o replace checando se tem 2 caracteres de espa�os e trocando por um, depois ele verifica novamente a condi��o, at� que a condi��o n�o seja mais atendida, ou seja, n�o seja mais true.
				 Ap�s parar vamos verificar a execu��o do processo com o select.
			
				 declare @vString varchar(100)
					 set @vString = 'SQL               SERVER               '

				 while charindex('  ', @vString) >0
					begin
						set @vString = replace(@vString, '  ', ' ')
					end
				 SELECT @vString 


*/