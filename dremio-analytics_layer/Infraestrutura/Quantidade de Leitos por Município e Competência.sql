 SELECT 
    m.cod_municipio,
    m.municipio,
    m.regiao_saude, 
    m.uf_sigla,
    lt.COMPETEN as competencia,
    SUM(lt.QT_SUS) AS quantidade_sus,
    SUM(lt.QT_NSUS) AS quantidade_nao_sus
FROM
    Dados.cnes.LT lt 
LEFT JOIN 
    "Analytics Layer".Territorial."Municípios - Hierarquia Completa" m ON lt.CODUFMUN = CAST(m.cod_municipio AS CHAR)
GROUP BY
    m.cod_municipio,
    m.municipio,
    m.regiao_saude, 
    m.uf_sigla,
    lt.COMPETEN

