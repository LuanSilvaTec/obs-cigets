SELECT 
    DIAG_PRINC AS cid_principal,
    AVG(DIAS_PERM) AS media_dias_internacao
FROM 
    Dados.sih.RD
GROUP BY DIAG_PRINC
ORDER BY media_dias_internacao DESC