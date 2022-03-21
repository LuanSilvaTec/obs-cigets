SELECT DISTINCT
    mrs.DS_NOMEPAD as regiao_pad,
    mrs.DS_NOME as regiao,
    uf.co_uf as cod_uf,
    uf.DS_NOMEPAD as uf_pad,
    uf.DS_NOME as uf,
    uf.DS_sigla as uf_sigla,
    mac.CO_MACSAUD as cod_macrorregiao,
    mac.DS_NOMEPAD as macrorregiao_pad,
    mac.DS_ABREV as macrorregiao,
    rs.CO_REGSAUD as cod_regsaud,
    rs.DS_NOMEPAD as regiao_saude_pad,
    rs.DS_NOME as regiao_saude,
    mun.CO_MUNICIP as cod_municipio,
    mun.DS_NOMEPAD as municipio_pad,
    mun.DS_NOME as municipio,
    ll.latitude,
    ll.longitude
FROM "Dados.territorial"."tb_municip.parquet" mun
INNER JOIN "Dados.territorial"."tb_uf.parquet" uf on uf.CO_UF = mun.CO_UF
INNER JOIN "Dados.territorial"."rl_municip_regsaud.parquet" rsm on rsm.CO_MUNICIP = mun.CO_MUNICIP
INNER JOIN "Dados.territorial"."tb_regsaud.parquet" rs on rs.CO_REGSAUD = rsm.CO_REGSAUD
INNER JOIN "Dados.territorial"."rl_municip_macsaud.parquet" mrsm on mrsm.CO_MUNICIP = mun.CO_MUNICIP
INNER JOIN "Dados.territorial"."tb_regiao.parquet" mrs on mrs.CO_REGIAO = uf.CO_REGIAO
INNER JOIN "Dados.territorial"."rl_regsaud_macsaud.parquet" rlmac on CAST(rlmac.CO_REGSAUD AS VARCHAR) = rs.CO_REGSAUD
INNER JOIN "Dados.territorial"."tb_macsaud.parquet" mac on CAST(rlmac.CO_MACSAUD AS VARCHAR) = mac.CO_MACSAUD
INNER JOIN "Dados.territorial"."lat_long.parquet" ll on CAST(mun.CO_MUNICIP AS VARCHAR) = ll.municipio
WHERE 
    mun.CO_STATUS = 'ATIVO' AND
    uf.CO_STATUS = 'ATIVO' AND
    rs.CO_STATUS = 'ATIVO' AND
    mrs.CO_STATUS = 'ATIVO' AND
    mac.CO_STATUS = 'ATIVO' 