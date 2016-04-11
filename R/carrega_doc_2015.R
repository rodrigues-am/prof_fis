##################################################
### Cria sumário de formação inicial para 2013
### Censo Escolar 2015 - Docente
##################################################

# Carrega bibliotecas
library(dplyr) # manipulação de dados

# Carrega variveis controle
source("~/R/prof_fis/R/var_controle.R")

# Carrega dados Docentes Sudeste
doc.sd <- read.csv("~/dados/censoescolar/2015/microdados_censo_escolar_2015/DADOS/DOCENTES_SUDESTE.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.sd <- filter(doc.sd, TP_TIPO_DOCENTE==c(1,5), # professores ativos 
                 TP_TIPO_TURMA!=5,TP_TIPO_TURMA!=4, # professores que não estão em AEE
                 IN_DISC_FISICA==1) # professores de física

# Carrega dados Docentes centro-oeste - CO
doc.co <- read.csv("~/dados/censoescolar/2015/microdados_censo_escolar_2015/DADOS/DOCENTES_CO.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.co <- filter(doc.co, TP_TIPO_DOCENTE==c(1,5), # professores ativos 
               TP_TIPO_TURMA!=5,TP_TIPO_TURMA!=4, # professores que não estão em AEE
               IN_DISC_FISICA==1) # professores de física

# Carrega dados Docentes Sul
doc.sul <- read.csv("~/dados/censoescolar/2015/microdados_censo_escolar_2015/DADOS/DOCENTES_SUL.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.sul <- filter(doc.sul, TP_TIPO_DOCENTE==c(1,5), # professores ativos 
                 TP_TIPO_TURMA!=5,TP_TIPO_TURMA!=4, # professores que não estão em AEE
                 IN_DISC_FISICA==1) # professores de física

# Carrega dados Docentes Norte
doc.nt <- read.csv("~/dados/censoescolar/2015/microdados_censo_escolar_2015/DADOS/DOCENTES_NORTE", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.nt <- filter(doc.nt, TP_TIPO_DOCENTE==c(1,5), # professores ativos 
                  TP_TIPO_TURMA!=5,TP_TIPO_TURMA!=4, # professores que não estão em AEE
                  IN_DISC_FISICA==1) # professores de física

# Carrega dados Docentes Nordeste
doc.nd <- read.csv("~/dados/censoescolar/2015/microdados_censo_escolar_2015/DADOS/DOCENTES_NORDESTE.CSV", sep="|", header=TRUE)

# Seleciona professores ativos que dão aulas de Física
doc.nd <- filter(doc.nd, TP_TIPO_DOCENTE==c(1,5), # professores ativos 
                 TP_TIPO_TURMA!=5,TP_TIPO_TURMA!=4, # professores que não estão em AEE
                 IN_DISC_FISICA==1) # professores de física

# Agrupa dados docentes nacionais
doc15 <- rbind(doc.co, doc.nd, doc.nt, doc.sd, doc.sul)

# remove variaveis auxiliares
rm(doc.co, doc.nd, doc.nt, doc.sd, doc.sul)

