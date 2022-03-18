SELECT 
    CONCAT(CODMUNRES, SUBSTR(dtobito, 5, 4)) AS chave,
    SUBSTR(dtobito, 5, 4) as ano,
    CODMUNRES,
    CASE
        WHEN (CAUSABAS LIKE 'E10%' OR CAUSABAS LIKE 'E11%' OR CAUSABAS LIKE 'E12%' OR CAUSABAS LIKE 'E13%' OR CAUSABAS LIKE 'E14%') THEN 'Diabetes Mellitus'
		WHEN (CAUSABAS LIKE 'I%') THEN 'Doenças do aparelho circulatório'
    END as doenca,
    COUNT(*) as quantidade
FROM Dados.sim.DO
WHERE
    (dtobito IS NOT NULL AND dtobito != '')
    AND CODMUNRES NOT LIKE '%0000'
    AND SUBSTR(dtobito, 5, 4) IN ('2015', '2016', '2017', '2018', '2019')
    AND ((CAUSABAS LIKE 'E10%' OR CAUSABAS LIKE 'E11%' OR CAUSABAS LIKE 'E12%' OR CAUSABAS LIKE 'E13%' OR CAUSABAS LIKE 'E14%') OR 
	(CAUSABAS LIKE 'I%'))
GROUP BY
    CONCAT(CODMUNRES, SUBSTR(dtobito, 5, 4)),
    SUBSTR(dtobito, 5, 4),
    CODMUNRES,
    CASE
        WHEN (CAUSABAS LIKE 'E10%' OR CAUSABAS LIKE 'E11%' OR CAUSABAS LIKE 'E12%' OR CAUSABAS LIKE 'E13%' OR CAUSABAS LIKE 'E14%') THEN 'Diabetes Mellitus'
		WHEN (CAUSABAS LIKE 'I%') THEN 'Doenças do aparelho circulatório'
    END