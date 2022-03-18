library(tidyverse)

setwd("~/GitHub/obs-cigets/analises-ad_hoc/dimensionamento/001 - metodologia necessidades gestantes/Oferta de profissionais APS e ginecologista")

cadger <- sqlQuery(channel, "SELECT * FROM(
                                SELECT CNES, FANTASIA, RAZ_SOCI, SUBSTR(CODUFMUN, 1,2) AS UF 
                                FROM Dados.cnes.CADGER
                            ) WHERE UF = '52'", as.is=c(TRUE))


cnes_pf <- sqlQuery(channel, "SELECT * FROM(
                                  SELECT CNES, CODUFMUN, CBO, NOMEPROF, SUBSTR(CBO, 1, 4) AS FAM_CBO, CNS_PROF, CONSELHO,  
                                      VINCULAC, VINCUL_C, VINCUL_A, VINCUL_N, PROF_SUS, PROFNSUS, HORAOUTR,HORAHOSP,
                                      HORA_AMB, COMPETEN, competencia
                                  FROM Dados.cnes.PF
                                  WHERE uf = 'GO')
                                  WHERE FAM_CBO = '2212' OR FAM_CBO = '2234' OR FAM_CBO = '3242' OR FAM_CBO = '5152'", 
                    as.is=c(TRUE))

cbo_farmacia <- sqlQuery(channel, 'SELECT * FROM Dados.cbo2002."ocupacao.parquet"', as.is = c(TRUE))


cnes_pf_tratado <- cnes_pf %>% 
              left_join(cadger, by = "CNES") %>% 
              left_join(cbo_farmacia, by = c("CBO" = "CODIGO")) %>% 
              filter(PROF_SUS == "1") %>% 
              mutate(ano = as.integer(str_sub(COMPETEN, end = 4))) %>% 
              group_by(CNES, FANTASIA, CODUFMUN, CBO, TITULO, ano, COMPETEN, competencia) %>% 
              summarise(outros = sum(HORAOUTR), hospitalar = sum(HORAHOSP),
                        ambulatorial = sum(HORA_AMB)) %>% 
              mutate(horas = outros + hospitalar + ambulatorial,
                     fte_40 = horas/40)

cnes_pf_tratado1 <- cnes_pf_tratado %>% 
              filter(!str_detect(FANTASIA, 'FARMACIA')) %>% 
              filter(!str_detect(FANTASIA, 'FARMACEUTICO')) %>% 
              filter(!str_detect(FANTASIA, 'FARMACEUTICA')) %>% 
              filter(!str_detect(FANTASIA, 'DROGARIA')) %>% 
              filter(!str_detect(FANTASIA, 'MEDICAMENT')) %>% 
              filter(CBO != "515210")

na <- cnes_pf_tratado1 %>% 
          filter(is.na(TITULO)) 

na <- unique(cnes_pf_tratado1$CBO)
na

prof_municipios <- cnes_pf_tratado %>% 
                      group_by(CODUFMUN, CBO, ano, COMPETEN) %>% 
                      summarise(fte = sum(fte_40))
                      



