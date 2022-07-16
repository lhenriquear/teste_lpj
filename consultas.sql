# Esboce uma consulta SQL que retorne o código de todos os vendedores que entre
 uma data DATA_INICIO e data DATA_FIM atendem aos seguintes requisitos:
    # Vendem quantidade de itens do produto de código PROD_1 maior que a
média de vendas por vendedor do produto de código PROD_1 em sua loja;


WITH
venda_mes (
    SELECT cod_vendedor,
    SUM(quantidade) venda,
    vnd.cod_loja
    FROM vendas vnd,
    vendedor vndr
    WHERE data BETWEEN data_inicio AND data_fim
    AND cod_produto='PROD_1'
    AND vnd.cod_vendedor=vndr.cod_vendedor
    Group by cod_vendedor, vnd.cod_loja
    )

media (
    SELECT AVG(quantidade) media,
    vnd.cod_loja
    FROM vendas vnd,
    vendedor vndr
    WHERE
    data BETWEEN data_inicio AND data_fim
    AND vnd.cod_vendedor=vndr.cod_vendedor
    AND cod_produto='PROD_1'
    Group by cod_loja
    )

SELECT cod_vendedor
FROM media, venda_mes
WHERE venda > media
AND media.cod_loja = venda_mes.cod_loja


    # Vendem quantidade de itens do produto de código PROD_2 maior que a média de vendas
por vendedor do produto de código PROD_2 nas lojas com mais de 1000 vendas do produto de
código PROD_2 no período;

WITH
venda_mes (
    SELECT cod_vendedor,
    SUM(quantidade) venda,
    vndr.cod_loja
    FROM vendas vnd,
    vendedor vndr
    WHERE data BETWEEN data_inicio AND data_fim
    AND cod_produto='PROD_2'
    AND vnd.cod_vendedor=vndr.cod_vendedor
    Group by cod_vendedor, vndr.cod_loja
    HAVING SUM(quantidade) > 1000
    )

media (
    SELECT AVG(quantidade) media,
    vndr.cod_loja
    FROM vendas vnd,
    vendedor vndr
    WHERE
    data BETWEEN data_inicio AND data_fim
    AND vnd.cod_vendedor=vndr.cod_vendedor
    AND cod_produto='PROD_2'
    Group by cod_loja
    )

SELECT cod_vendedor
FROM media, venda_mes
WHERE venda > media
AND media.cod_loja = venda_mes.cod_loja


#Esboce uma consulta SQL que retorne o código de todos os vendedores cujas vendas
#do produto de código PROD_1 entre DATA_INICIO e DATA_FIM foram sempre crescentes dia-a-dia


WITH
ordem(
SELECT
cod_vendedor,
cod_produto,
data
SUM(quantidade) OVER(PARTITION BY cod_vendedor ORDER BY DATE ASC ) vendas
FROM vendas
WHERE cod_produto ='PROD_1'
AND data BETWEEN data_inicio AND data_fim
)


IF(ordem.vendas-LAG(ordem.vendas,1)OVER(ORDER BY data ASC)) >0
SELECT cod_vendedor
FROM ordem

