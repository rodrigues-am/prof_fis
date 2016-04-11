##################################################
### Cria sumário de formação inicial para 2014
### Censo Escolar 2014 - Docente
##################################################

# Carrega bibliotecas
library(dplyr) # manipulação de dados

# Carrega variveis controle
source("~/R/prof_fis/R/var_controle.R")

# Carrega dados Docentes Sudeste
doc.sd <- read.csv("~/dados/censoescolar/2014/DADOS/DOCENTES_SUDESTE.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.sd <- filter(doc.sd, ID_TIPO_DOCENTE=="1", # professores ativos 
                 ID_FISICA=="1") # professores de física

# Carrega dados Docentes centro-oeste - CO
doc.co <- read.csv("~/dados/censoescolar/2014/DADOS/DOCENTES_CO.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.co <- filter(doc.co, ID_TIPO_DOCENTE=="1", # professores ativos 
                 ID_FISICA=="1") # professores de física


# Carrega dados Docentes Sul
doc.sul <- read.csv("~/dados/censoescolar/2014/DADOS/DOCENTES_SUL.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.sul <- filter(doc.sul, ID_TIPO_DOCENTE=="1", # professores ativos 
                  ID_FISICA=="1") # professores de física

# Carrega dados Docentes Norte
doc.nt <- read.csv("~/dados/censoescolar/2014/DADOS/DOCENTES_NORTE.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.nt <- filter(doc.nt, ID_TIPO_DOCENTE=="1", # professores ativos 
                 ID_FISICA=="1") # professores de física

# Carrega dados Docentes Nordeste
doc.nd <- read.csv("~/dados/censoescolar/2014/DADOS/DOCENTES_NORDESTE.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.nd <- filter(doc.nd, ID_TIPO_DOCENTE=="1", # professores ativos 
                 ID_FISICA=="1") # professores de física


# Agrupa dados docentes nacionais
doc14 <- rbind(doc.co, doc.nd, doc.nt, doc.sd, doc.sul)

# remove variaveis auxiliares
rm(doc.co, doc.nd, doc.nt, doc.sd, doc.sul)
