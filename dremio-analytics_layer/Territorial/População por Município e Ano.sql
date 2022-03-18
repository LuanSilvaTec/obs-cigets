SELECT 
    m.uf_sigla,
    m.regiao_saude,
    m.cod_municipio,
    m.municipio,
    p.ano,
    p.populacao
FROM "Analytics Layer".Territorial."Municípios - Hierarquia Completa" m 
LEFT JOIN Dados.populacional."IBGE_2020.parquet" p ON m.cod_municipio = p.municipio