/*
Fun��es de data: getdate,datediff, dateadd, datepart
	   Unidades: year, month, day

Tipos de data e hora no T-SQL(transact- SQL):
		- Datetime - conta a data a partir de 01/01/1753 e armazena at� cent�simos de segundos.
		- SmallDateTime - conta a data a partir de 01/01/1900 e armazena at� segundos.
*/

---- GETDATE()-> quando utilizada tras a data atual.

SELECT getdate(); --tr�s a data no formato americano(2022-11-03)

--A fun��o acima pode ser usada em conjunto com a fun��o convert()

SELECT convert(char, getdate(), 103) --Converte a data atual para o tipo char, utilizando o formato dd/mm/yyyy (103)
SELECT convert(char, getdate(), 102) --Converte a data atual para o tipo char, utilizando o formato yyyy.mm.dd (102)
SELECT convert(char, getdate(), 1) --Converte a data atual para o tipo char, utilizando o formato mm/dd/aa (1)
SELECT convert(char, getdate(), 2) --Converte a data atual para o tipo char, utilizando o formato aa.mm.dd (2)

--Para extrair o dia, m�s ou ano dessa data podemos:

SELECT day(getdate()) as dia
SELECT month(getdate()) as m�s
SELECT year(getdate()) as ano
SELECT day(getdate()) as dia, month(getdate()) as m�s, year(getdate()) as ano

--No lugar da fun��o getdate � possivel utilizar um campo ou uma data:

SELECT year(getdate()) as ano
SELECT year(data_nascimento) as ano from Alunos
SELECT year('11/11/2022') as ano

----DATEPART -> Retorna parte da data

SELECT datepart(day, getdate()) -- O resultado desta instru��o � o mesmo que SELECT day(getdate()) as dia
SELECT datepart(month, getdate()) -- O resultado desta instru��o � o mesmo que SELECT month(getdate()) as m�s
SELECT datepart(year, getdate()) -- O resultado desta instru��o � o mesmo que SELECT year(getdate()) as ano

-- Assim como na fun��o getdate(), tamb�m � possivel utilizar campos e datas na fun��o datepart()

SELECT datepart(day, getdate())
SELECT datepart(day, '11/11/1972')
SELECT datepart(day, data_nascimento) from Alunos -- Quando utiliza-se um campo � preciso especificar a tabela.

--Tamb�m � possivel extrair as datas sem repeti��o utilizando o distinct()

SELECT datepart(year, data_nascimento) from Alunos
SELECT distinct(datepart(year, data_nascimento)) as ano from Alunos -- datas sem repeti��o 
SELECT distinct(datepart(year, data_nascimento)) as ano from Alunos order by 1 -- datas sem repeti��o em ordem crescente.

----DATEADD -> Significa que eu quero adicionar/subtrair algo a/da minha data.

/*
Os par�metros em rela��o a essa fun��o s�o:
	- Intervalo: year, month e day
	- Incremento: soma ou subtrai -- pode ser positivo(adiciona) ou negativo(subtrai).
									 Quando positivo ele soma a data com o que est� no terceiro argumento.
*/

-- Aparecer� a data e a hora
SELECT dateadd(year,-2, getdate()) -- Subtrai 2 anos da data atual.
SELECT dateadd(month,3, getdate()) -- Soma 3 meses a data atual.
SELECT dateadd(day,28, getdate()) -- Soma 28 dias a data atual.
SELECT dateadd(hour,3, getdate()) -- Soma 3 horas a data atual.

-- Tamb�m � possivel utilizar a fun��o convert():

SELECT convert(date, dateadd(year,-2, getdate())) -- S� aparecer� a data --Convertendo para o formato data
SELECT convert(date, dateadd(month,3, getdate())) -- S� aparecer� a data --Convertendo para o formato data
SELECT convert(date, dateadd(day,28, getdate())) -- S� aparecer� a data --Convertendo para o formato data

SELECT convert(datetime, dateadd(hour,3, getdate())) --Convertendo para o formato datatime
SELECT convert(smalldatetime, dateadd(hour,3, getdate())) --Convertendo para o formato smalldatatime
SELECT convert(datetime, dateadd(hour,3, getdate())) as DateT, convert(smalldatetime, dateadd(hour,3, getdate())) as SmallD

----DATEDIFF -> Diferen�a entre datas

SELECT datediff(year, getdate(),dateadd(year,4, getdate())) as anos; --Calcula a diferen�a em anos da minha data atual, at� a minha data atual mais 4 anos.
SELECT datediff(month, getdate(),dateadd(year,2, getdate())) as meses; --Calcula a diferen�a em meses da minha data atual, at� a minha data atual mais 2 anos.
SELECT datediff(day, getdate(),dateadd(year,3, getdate())) as dias; --Calcula a diferen�a em dias da minha data atual, at� a minha data atual mais 3 anos.

SELECT datediff(hour, '02/06/1995', getdate()) as horas_vida; -- Retorna as horas que tenho de vida desde o meu nascimento at� a data atual.
SELECT datediff(minute, '02/06/1995',  getdate()) as "minutos vida"; -- Retorna as minutos que tenho de vida desde o meu nascimento at� a data atual.
SELECT datediff(second, '02/06/1995',  getdate()) as segundos_vida; -- Retorna as segundos que tenho de vida desde o meu nascimento at� a data atual.