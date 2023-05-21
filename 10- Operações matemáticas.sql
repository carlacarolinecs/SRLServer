/*
Opera��es matem�ticas

Existem duas formas de realiza-las:
1. Linha por linha
2. Por agrega��o
*/
-- Soma
SELECT 1 + 2; -- O resultado n�o vai conter o nome da coluna.
SELECT 1 + 2 as Resultado;
SELECT 458.99 + 899 + 7.77 as Resultado; --� ponto e n�o virgula

--Subtra��o
SELECT 233 - 78.99 as Resultado;
SELECT 233 - (78.99+333) as Resultado; -- Utiliza-se paranteses para impor uma certa ordem nas opera��es matem�ticas.

--Divis�o
SELECT 50/2 as Resultado;
SELECT 49/2 as Resultado; -- O resultado � 24 por ser uma divis�o de n�meros inteiros, mas � possivel contornar isso.
SELECT 49.0/2 as Resultado;  -- Vai fazer com que exiba as classes decimais.
SELECT 49.99/2 as Resultado;

--Multiplica��o
SELECT 50 * 2 as Resultado;
SELECT 50.88 * 3 as Resultado; --Resultado com casas decimais

/*
Observa��o: Toda opera��o matem�tica que voc� fizer com n�meros inteiros, retornar� n�meros inteiros.
			Toda opera��o matem�tica que voc� fizer com n�meros decimais, retornar� n�meros decimais.
Aten��o: Isso s� vale para o Oracle --> SELECT 50 * 2 from dual;
*/

--Potencia��o
SELECT 2^2; --Vai ter resultado zero, pois essa opera��o no SQL � diferente, n�s temos que usar uma fun��o para fazer a potencia��o.
SELECT square(2) as Resultado; -- A fun��o square() retorna o quadrado de um n�mero (n�mero x ele mesmo).
SELECT power(3,3) as Resultado; -- A fun��o power() releva um n�mero a n pot�ncia. --3*3*3
SELECT power(2,8) as Resultado; -- 2*2*2*2*2*2*2*2

--Porcentagem
SELECT 100 * 1.1 as Resultado;
SELECT 100 + (100 * 0.1) as Resultado; -- Possui o mesmo resultado que o de cima.
SELECT 100 + (100 * 10%) as Resultado; -- Retorna um erro, por causa do sinal de porcentagem.
SELECT 100 * 0.9 as Resultado; --Utiliza-se quando se deseja tirar 10% de 100 (1/10*9); O resultado � 90
SELECT 100 * 0.1 as Resultado; -- Resultado 10(1/10)
SELECT 100 * 0.01 as Resultado; -- 1% de 100 (1/100)

--ABS: Retorna o n�mero sem sinal.
SELECT abs(-100) as Resultado; -- Retorna 100
SELECT abs(100-999) as Resultado;

--Raiz quadrada
SELECT sqrt(49) as Resultado;
SELECT sqrt(7) as Resultado;

--PI
SELECT pi() as Resultado;

--Data Atual
SELECT getdate() as Resultado;

--Signal: Retorna -1 quando o n�mero � negativo e 1 quando o n�mero for positivo.
SELECT sign(-10) as Resultado; -- Retorna -1
SELECT sign(10) as Resultado;-- Retorna 1
SELECT sign(NULL) as Resultado; -- Retorna NULL
SELECT sign(0) as Resultado; -- -- Retorna 0
