if (!require(RODBC)) { install.packages(RODBC); require(RODBC) }

dremio_host <- "200.137.215.27"
dremio_port <- "31010"
dremio_uid <- "***"
dremio_pwd <- "***"

channel <- odbcDriverConnect(sprintf("DRIVER=Dremio Connector;HOST=%s;PORT=%s;UID=%s;PWD=%s;
                                     AUTHENTICATIONTYPE=Basic Authentication;CONNECTIONTYPE=Direct", 
                                     jdremio_host, dremio_port, dremio_uid, dremio_pwd))


nascimentos <- sqlQuery(channel, "SELECT * FROM(
                                      SELECT SUBSTRING(CODMUNRES, 1, 2) AS UF, CODMUNRES, DTNASC, 
                                      COUNT(*) AS contagem FROM Dados.sinasc.DN
                                      GROUP BY CODMUNRES, DTNASC)
                                  WHERE UF = '52'", as.is=c(TRUE))


nascimentos2020 <- sqlQuery(channel,"SELECT * FROM(SELECT SUBSTRING(CODMUNRES, 1, 2) AS UF, CODMUNRES, DTNASC, 
                                                    COUNT(*) AS contagem FROM Dados.sinasc.preliminar.sinasc_2020
                                                    GROUP BY CODMUNRES, DTNASC)
                                       WHERE UF = '52'", as.is=c(TRUE))


nascimentos2021 <- sqlQuery(channel,"SELECT * FROM(SELECT SUBSTRING(CODMUNRES, 1, 2) AS UF, CODMUNRES, DTNASC, 
                                                    COUNT(*) AS contagem FROM Dados.sinasc.preliminar.sinasc_2021                                                    GROUP BY CODMUNRES, DTNASC)
                                       WHERE UF = '52'", as.is=c(TRUE))