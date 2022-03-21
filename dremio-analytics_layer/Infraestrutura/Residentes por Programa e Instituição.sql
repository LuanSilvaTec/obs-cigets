SELECT 
    Programa,
    Instituição,
    COUNT(DISTINCT CPF) AS quantidade 
FROM Dados.cnrm."cnrm.parquet"
GROUP BY     
    Programa,
    Instituição