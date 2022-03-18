SELECT 
    NU_ANO_INGRESSO,
    COUNT(*) as quantidade
 FROM Dados."inep_censo_superior"."2019"."sup_aluno_2019.parquet"
 GROUP BY 
 NU_ANO_INGRESSO
 ORDER BY NU_ANO_INGRESSO ASC