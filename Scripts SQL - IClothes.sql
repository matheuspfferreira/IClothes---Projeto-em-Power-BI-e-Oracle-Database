--------------------------------------------------------------------------------
-- Visualizando os Três Produtos Mais Populares (Mais Vendidos)

-- Criando uma View (Visão)
CREATE VIEW VW_PRODUTOS_QUANTIDADE_VENDIDA AS
SELECT 

    TDP.NOME_PRODUTO AS "NOME DO PRODUTO",
    SUM(TV.QUANTIDADE_COMPRADA) AS "QUANTIDADE VENDIDA"
    
FROM TB_PRODUTOS TDP
INNER JOIN TB_VENDAS TV
ON 

    TDP.CODIGO_PRODUTO = TV.CODIGO_PRODUTO

GROUP BY TDP.NOME_PRODUTO
ORDER BY SUM(TV.QUANTIDADE_COMPRADA) DESC;

-- Filtrando as Três Primeiras Linhas da View (Visão)
SELECT 

    "NOME DO PRODUTO", 
    "QUANTIDADE VENDIDA"
    
FROM VW_PRODUTOS_QUANTIDADE_VENDIDA
WHERE (ROWNUM <= 3);
--------------------------------------------------------------------------------
-- Visualizando o Cliente Mais Ativo (Realizou o Maior Número de Compras)

-- Criando uma View (Visão)
CREATE VIEW VW_QUANT_COMPRAS_CLIENTES AS
SELECT 

    TDC.NOME_CLIENTE AS "NOME DO CLIENTE",
    COUNT(*) AS "COMPRAS EFETUADAS"
    
FROM TB_CLIENTES TDC
INNER JOIN TB_VENDAS TV
ON 

    TDC.CODIGO_CLIENTE = TV.CODIGO_CLIENTE
    
GROUP BY TDC.NOME_CLIENTE
ORDER BY "COMPRAS EFETUADAS" DESC;

-- Visualizando o Cliente com Maior Número de Compras
SELECT 

    "NOME DO CLIENTE", 
    "COMPRAS EFETUADAS"

FROM VW_QUANT_COMPRAS_CLIENTES
WHERE (ROWNUM <= 1);

--------------------------------------------------------------------------------
-- Visualizando o Desempenho de cada Vendedor por Mês

-- Criando uma View (Visão)
CREATE VIEW VW_DESEMPENHO_VENDEDORES_MES AS
SELECT 

    EXTRACT(MONTH FROM TBV.DATA_VENDA) AS DATA,
    TBVEN.NOME_VENDEDOR AS NOME_VENDEDOR,
    SUM(TBV.VALOR_VENDA) AS FATURAMENTO
    
FROM TB_VENDEDORES TBVEN
INNER JOIN TB_VENDAS TBV
ON 

    TBVEN.CODIGO_VENDEDOR = TBV.CODIGO_VENDEDOR
    
GROUP BY 

    EXTRACT(MONTH FROM TBV.DATA_VENDA), TBVEN.NOME_VENDEDOR
    
ORDER BY DATA;

-- Visualizando o Desempenho Mensal de Cada Vendedor
SELECT 

    DATA, 
    NOME_VENDEDOR AS "NOME DO VENDEDOR", 
    FATURAMENTO
    
FROM VW_DESEMPENHO_VENDEDORES_MES;



