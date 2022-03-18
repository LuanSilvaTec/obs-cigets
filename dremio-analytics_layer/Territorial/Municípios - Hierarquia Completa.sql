SELECT DISTINCT
    mrs.DS_NOMEPAD as regiao_pad,
    mrs.DS_NOME as regiao,
    uf.DS_NOMEPAD as uf_pad,
    uf.DS_NOME as uf,
    uf.DS_sigla as uf_sigla,
    rs.CO_REGSAUD as cod_regsaud,
    rs.DS_NOMEPAD as regiao_saude_pad,
    rs.DS_NOME as regiao_saude,
    mun.CO_MUNICIP as cod_municipio,
    mun.DS_NOMEPAD as municipio_pad,
    mun.DS_NOME as municipio
FROM "Dados.territorial"."tb_municip.parquet" mun
INNER JOIN "Dados.territorial"."tb_uf.parquet" uf on uf.CO_UF = mun.CO_UF
INNER JOIN "Dados.territorial"."rl_municip_regsaud.parquet" rsm on rsm.CO_MUNICIP = mun.CO_MUNICIP
INNER JOIN "Dados.territorial"."tb_regsaud.parquet" rs on rs.CO_REGSAUD = rsm.CO_REGSAUD
INNER JOIN "Dados.territorial"."rl_municip_macsaud.parquet" mrsm on mrsm.CO_MUNICIP = mun.CO_MUNICIP
INNER JOIN "Dados.territorial"."tb_regiao.parquet" mrs on mrs.CO_REGIAO = uf.CO_REGIAO
WHERE 
    mun.CO_STATUS = 'ATIVO' AND
    uf.CO_STATUS = 'ATIVO' AND
    rs.CO_STATUS = 'ATIVO' AND
    mrs.CO_STATUS = 'ATIVO'