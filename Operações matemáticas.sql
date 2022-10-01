/*
Operações matemáticas

Existem duas formas de realiza-las:
1. Linha por linha
2. Por agregação
*/
-- Soma
SELECT 1 + 2; -- O resultado não vai conter o nome da coluna.
SELECT 1 + 2 as Resultado;
SELECT 458.99 + 899 + 7.77 as Resultado; --É ponto e não virgula

--Subtração
SELECT 233 - 78.99 as Resultado;
SELECT 233 - (78.99+333) as Resultado; -- Utiliza-se paranteses para impor uma certa ordem nas operações matemáticas.

--Divisão
SELECT 50/2 as Resultado;
SELECT 49/2 as Resultado; -- O resultado é 24 por ser uma divisão de números inteiros, mas é possivel contornar isso.
SELECT 49.0/2 as Resultado;  -- Vai fazer com que exiba as classes decimais.
SELECT 49.99/2 as Resultado;

--Multiplicação
SELECT 50 * 2 as Resultado;
SELECT 50.88 * 3 as Resultado; --Resultado com casas decimais

/*
Observação: Toda operação matemática que você fizer com números inteiros, retornará números inteiros.
			Toda operação matemática que você fizer com números decimais, retornará números decimais.
Atenção: Isso só vale para o Oracle --> SELECT 50 * 2 from dual;
*/

--Potenciação
SELECT 2^2; --Vai ter resultado zero, pois essa operação no SQL é diferente, nós temos que usar uma função para fazer a potenciação.
SELECT square(2) as Resultado; -- A função square() retorna o quadrado de um número (número x ele mesmo).
SELECT power(3,3) as Resultado; -- A função power() releva um número a n potência. --3*3*3
SELECT power(2,8) as Resultado; -- 2*2*2*2*2*2*2*2

--Porcentagem
SELECT 100 * 1.1 as Resultado;
SELECT 100 + (100 * 0.1) as Resultado; -- Possui o mesmo resultado que o de cima.
SELECT 100 + (100 * 10%) as Resultado; -- Retorna um erro, por causa do sinal de porcentagem.
SELECT 100 * 0.9 as Resultado; --Utiliza-se quando se deseja tirar 10% de 100 (1/10*9); O resultado é 90
SELECT 100 * 0.1 as Resultado; -- Resultado 10(1/10)
SELECT 100 * 0.01 as Resultado; -- 1% de 100 (1/100)

--ABS: Retorna o número sem sinal.
SELECT abs(-100) as Resultado; -- Retorna 100
SELECT abs(100-999) as Resultado;

--Raiz quadrada
SELECT sqrt(49) as Resultado;
SELECT sqrt(7) as Resultado;

--PI
SELECT pi() as Resultado;

--Data Atual
SELECT getdate() as Resultado;

--Signal: Retorna -1 quando o número é negativo e 1 quando o número for positivo.
SELECT sign(-10) as Resultado; -- Retorna -1
SELECT sign(10) as Resultado;-- Retorna 1
SELECT sign(NULL) as Resultado; -- Retorna NULL
SELECT sign(0) as Resultado; -- -- Retorna 0
