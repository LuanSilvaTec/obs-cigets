SELECT
    *
FROM (
    SELECT
        SUBSTR(pf.COMPETEN, 0, 4) AS ano,
        SUBSTR(pf.COMPETEN, 5, 2) AS mes,
        u."DESCRIÇÃO" as tipo_unidade,
        CASE
            WHEN u."TIPO DE ESTABELECIMENTO" IS NULL THEN 'Ignorado'
            WHEN u."TIPO DE ESTABELECIMENTO" IN ('01','02', '45', '71', '72') THEN 'APS'
            ELSE 'Atenção Secundária'
        END as nivel_atencao,
        pf.cbo,
        CASE
            WHEN pf.CBO LIKE '225%' OR pf.CBO LIKE '2231%' THEN 'Médico'
            WHEN pf.CBO LIKE '2235%' THEN 'Enfermeiro'
        END AS categoria,
        o.titulo AS especialidade,
        SUM(HORAOUTR+HORAHOSP+HORA_AMB) AS FTE,
        COUNT(*) AS quantidade
    FROM Dados.cnes.PF pf
    LEFT JOIN Dados.cnes."TP_UNID.parquet" u ON pf.tp_unid = u."TIPO DE ESTABELECIMENTO"
    LEFT JOIN Dados.cbo2002."ocupacao.parquet" o ON pf.cbo = TO_CHAR(o.codigo, '#')
    WHERE 
        uf = 'GO'
        and prof_sus = '1'
        and (pf.CBO LIKE '225%' OR pf.CBO LIKE '2231%' OR pf.CBO LIKE '2235%')
    GROUP BY
        SUBSTR(pf.COMPETEN, 0, 4),
        SUBSTR(pf.COMPETEN, 5, 2),
        u."DESCRIÇÃO",
        CASE
            WHEN u."TIPO DE ESTABELECIMENTO" IS NULL THEN 'Ignorado'
            WHEN u."TIPO DE ESTABELECIMENTO" IN ('01','02', '45', '71', '72') THEN 'APS'
            ELSE 'Atenção Secundária'
        END,
        pf.cbo,
        CASE
            WHEN pf.CBO LIKE '225%' OR pf.CBO LIKE '2231%' THEN 'Médico'
            WHEN pf.CBO LIKE '2235%' THEN 'Enfermeiro'
        END,
        o.titulo
)
WHERE
    nivel_atencao = 'APS'
    OR (nivel_atencao = 'Atenção Secundária' AND cbo = '225250')