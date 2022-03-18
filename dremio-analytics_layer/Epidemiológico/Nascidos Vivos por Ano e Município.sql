SELECT 
    CODMUNRES,
    SEXO,
    SUBSTR(DTNASC, 5, 4) AS ano,
    COUNT(*) as qtd
FROM Dados.sinasc.DN
group by 
    CODMUNRES,
    SEXO,
    ano
order by ano asc