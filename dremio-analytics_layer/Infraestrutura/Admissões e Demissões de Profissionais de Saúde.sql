SELECT 
    SUBSTR(competência, 1, 4) AS ano,
    SUBSTR(competência, 5, 2) AS mes,
    município, 
    CASE
        WHEN seção = 'A' THEN 'Agricultura, Pecuária, Produção Florestal, Pesca e AqÜIcultura'
        WHEN seção = 'B' THEN 'Indústrias Extrativas'
        WHEN seção = 'C' THEN 'Indústrias de Transformação'
        WHEN seção = 'D' THEN 'Eletricidade e Gás'
        WHEN seção = 'E' THEN 'Água, Esgoto, Atividades de Gestão de Resíduos e Descontaminação'
        WHEN seção = 'F' THEN 'Construção'
        WHEN seção = 'G' THEN 'Comércio, Reparação de Veículos Automotores e Motocicletas'
        WHEN seção = 'H' THEN 'Transporte, Armazenagem e Correio'
        WHEN seção = 'I' THEN 'Alojamento e Alimentação'
        WHEN seção = 'J' THEN 'Informação e Comunicação'
        WHEN seção = 'K' THEN 'Atividades Financeiras, de Seguros e Serviços Relacionados'
        WHEN seção = 'L' THEN 'Atividades Imobiliárias'
        WHEN seção = 'M' THEN 'Atividades Profissionais, Científicas e Técnicas'
        WHEN seção = 'N' THEN 'Atividades Administrativas e Serviços Complementares'
        WHEN seção = 'O' THEN 'Administração Pública, Defesa e Seguridade Social'
        WHEN seção = 'P' THEN 'Educação'
        WHEN seção = 'Q' THEN 'Saúde Humana e Serviços Sociais'
        WHEN seção = 'R' THEN 'Artes, Cultura, Esporte e Recreação'
        WHEN seção = 'S' THEN 'Outras Atividades de Serviços'
        WHEN seção = 'T' THEN 'Serviços Domésticos'
        WHEN seção = 'U' THEN 'Organismos Internacionais e Outras Instituições Extraterritoriais'
        WHEN seção = 'Z' THEN 'Não identificado'
    END AS secao_cnae,
	CASE
		WHEN TO_CHAR(cbo2002ocupação, '#') LIKE '225%' OR TO_CHAR(cbo2002ocupação, '#') LIKE '2231%' THEN 'Médico'
		WHEN TO_CHAR(cbo2002ocupação, '#') LIKE '2234%' THEN 'Farmacêutico'
		WHEN TO_CHAR(cbo2002ocupação, '#') LIKE '2235%' THEN 'Enfermeiro'
		WHEN TO_CHAR(cbo2002ocupação, '#') LIKE '2236%' THEN 'Fisioterapeuta'
		WHEN TO_CHAR(cbo2002ocupação, '#') LIKE '2237%' THEN 'Nutricionista'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '515105' THEN 'Agente Comunitário de Saúde'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '322205' OR TO_CHAR(cbo2002ocupação, '#') = '322230' THEN 'Técnico/Auxiliar de Enfermagem'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '251605' THEN 'Assistente Social'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '221105' THEN 'Biólogo'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '221205' THEN 'Biomédico'
		WHEN TO_CHAR(cbo2002ocupação, '#') LIKE '2241%' THEN 'Profissional da Educação Física'
		WHEN TO_CHAR(cbo2002ocupação, '#') LIKE '2238%' THEN 'Fonoaudiólogo'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '223305' THEN 'Médico Veterinário'
		WHEN TO_CHAR(cbo2002ocupação, '#') LIKE '2232%' THEN 'Cirurgiões-dentistas'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '251510' THEN 'Psicólogo Clínico'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '223905' THEN 'Terapeuta Ocupacional'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '324115' THEN 'Técnico em radiologia e imagenologia'
		WHEN TO_CHAR(cbo2002ocupação, '#') = '322405' THEN 'Técnico em saúde bucal'
    END AS categoria,
    TO_CHAR(cbo2002ocupação, '#') AS cbo,
    o.titulo AS especialidade,
    idade,
    horascontratuais,
    CASE
        WHEN raçacor = 1 THEN 'Branca' 
        WHEN raçacor = 2 THEN 'Preta' 
        WHEN raçacor = 3 THEN 'Parda'
        WHEN raçacor = 4 THEN 'Amarela'
        WHEN raçacor = 5 THEN 'Indígena'
        WHEN raçacor = 6 THEN 'Não informada'
        ELSE 'Não Identificado'
    END as raca_cor,
    CASE
        WHEN sexo = 1 THEN 'Masculino' 
        WHEN sexo = 3 THEN 'Feminino' 
        ELSE 'Não Identificado'
    END as sexo,
    CASE
        WHEN saldomovimentação > 0 THEN 'Admissão'
        WHEN saldomovimentação < 0 THEN 'Demissão'
        ELSE 'Verificar'
    END as tipo_movimentacao,
    SUM(saldomovimentação) AS qtd
 FROM 
    Dados.caged."novo_mov"
LEFT JOIN
    Dados.cbo2002."ocupacao.parquet" o ON TO_CHAR(cbo2002ocupação, '#') = TO_CHAR(o.codigo, '#')
WHERE
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '2236%' AND CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) != '2236I1') OR  -- Fisioterapeuta
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '2237%') OR -- Nutricionista
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '2235%') OR -- Enfermeiro
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '2234%') OR -- Farmaceutico
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '225%' OR CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '2231%') OR -- Medico
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '515105') OR -- ACS
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '322205' OR CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '322230') OR-- Tec/Aux Enfermagen
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '251605') OR -- Assistente Social
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '221105') OR -- Biólogo
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '221205') OR -- Biomédico
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '2241%') OR -- 'Profissional da Educação Física'
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '2238%') OR -- Fonoaudiólogo
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '223305') OR -- Médico Veterinário
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) LIKE '2232%') OR -- Cirurgiões-dentistas
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '251510') OR -- Psicólogo Clínico
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '223905')  or -- Terapeuta Ocupacional
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '324115') OR -- Técnico em radiologia e imagenologia
    (CAST(TO_CHAR(cbo2002ocupação, '#') AS VARCHAR) = '322405')  -- Técnico em saúde bucal
GROUP BY
    ano,
    mes,
    município,
    secao_cnae,
    TO_CHAR(cbo2002ocupação, '#'),
    O.TITULO,
    idade,
    horascontratuais,
    raca_cor,
    sexo,
    tipo_movimentacao