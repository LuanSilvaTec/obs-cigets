SELECT 
    m.cod_municipio,
    m.municipio,
    o.titulo AS ocupacao,
    COUNT(*) AS quantidade
FROM Dados.cnes.PF pf
LEFT JOIN Dados.cbo2002."ocupacao.parquet" o ON CAST(o.CODIGO AS CHAR) = pf.cbo
LEFT JOIN 
    "Analytics Layer".Territorial."Municípios - Hierarquia Completa" m ON pf.CODUFMUN = CAST(m.cod_municipio AS CHAR)
WHERE pf.COMPETEN = '202101'
GROUP BY 
    m.cod_municipio,
    m.municipio,
    o.titulo