########################################################
# Dados docentes em 2014
# Carrega e seleciona os professores de Física
########################################################

#Carrega bibliotecas
library("repmis")

# Carrega e seleciona os dados
# Primeiramente por professores ativos na sala de aula e posteriormente por professores que lecionam Física

doc14.co<-repmis::source_DropboxData("DOCENTES_CO.CSV","no9cqo7r4n3q8ix",sep = "|", header = TRUE)
doc14.co<- subset(doc14.co,ID_TIPO_DOCENTE=="1")
doc14.co<- subset(doc14.co,ID_FISICA=="1")

doc14.nt<-repmis::source_DropboxData("DOCENTES_NORTE.CSV","hjmn7299hwysmjk",sep = "|", header = TRUE)
doc14.nt<- subset(doc14.nt,ID_TIPO_DOCENTE=="1")
doc14.nt<- subset(doc14.nt,ID_FISICA=="1")

doc14.sul<-repmis::source_DropboxData("DOCENTES_SUL.CSV","hnp4o9581m7ppa6",sep = "|", header = TRUE)
doc14.sul<- subset(doc14.sul,ID_TIPO_DOCENTE=="1")
doc14.sul<- subset(doc14.sul,ID_FISICA=="1")

# Muito pesado para ser carregado via dropbox @resolver
# doc14.sd<-repmis::source_DropboxData("DOCENTES_SUDESTE.CSV","ipck9uztb7ue4u7",sep = "|", header = TRUE)
doc14.sd<- read.csv("~/dados/censoescolar/2014/DADOS/DOCENTES_SUDESTE.CSV", sep="|", header=TRUE)
doc14.sd<- subset(doc14.sd,ID_TIPO_DOCENTE=="1")
doc14.sd<- subset(doc14.sd,ID_FISICA=="1")

doc14.nd<-repmis::source_DropboxData("DOCENTES_NORDESTE.CSV","9jp3v8cbpoci9zg",sep = "|", header = TRUE)
doc14.nd<- subset(doc14.nd,ID_TIPO_DOCENTE=="1")
doc14.nd<- subset(doc14.nd,ID_FISICA=="1")

# Agrupa dados docentes nacionais
doc14<- rbind(doc14.co, doc14.nd, doc14.nt, doc14.sd, doc14.sul)

# Remove informação antiga
rm(doc14.co)
rm(doc14.nd)
rm(doc14.nt)
rm(doc14.sd)
rm(doc14.sul)