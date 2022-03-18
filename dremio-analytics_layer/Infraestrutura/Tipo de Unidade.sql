SELECT 
    CODUFMUN as cod_municipio,
    st.cnes,
    st.COMPETEN as competencia,
    u."DESCRIÇÃO" as tipo
FROM Dados.cnes.ST st
LEFT JOIN Dados.cnes."tp_unid.parquet" as u ON st.TP_UNID = u."TIPO DE ESTABELECIMENTO"