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


