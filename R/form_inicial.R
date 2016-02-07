####################################################################
### Insere formação dos professores    #############################
### Por proximidade com a licenciatura em Física ###################
####################################################################

#Carrega bibliotecas
library("plyr")
library("reshape2")
library("survival")
library("doBy")

# Carrega variveis controle
source("~/R/prof_fis/R/var_controle.R")

# A variavel doc14 é a compilação do Censo escolar considerando professores 
# em atividade e que lecionam Física

form<-doc14
form$TP_FORM<-as.factor(NA) # Cria variavel TP_FORM - tipo de formação inicial

# Cola as linhas correspondentes a formação inicial 
# Empilha transformando em uma lista única as formações possiveis
# Cada professor pode ter até 3 cursos de graduação registrados em variaveis diferentes.

form<- rbind(form[,list(FK_COD_DOCENTE,FK_COD_ESTADO=FK_COD_ESTADO_DEND, TP_FORM, FK_COD_ESCOLARIDADE, ID_SITUACAO_CURSO=ID_SITUACAO_CURSO_1,FK_CLASSE_CURSO=FK_CLASSE_CURSO_1, 
                        FK_COD_AREA_OCDE=FK_COD_AREA_OCDE_1, ID_LICENCIATURA=ID_LICENCIATURA_1,ID_COM_PEDAGOGICA=ID_COM_PEDAGOGICA_1, ID_COM_PEDAGOGICA=ID_COM_PEDAGOGICA_1,
                        NU_ANO_INICIO=NU_ANO_INICIO_1, NU_ANO_CONCLUSAO=NU_ANO_CONCLUSAO_1, ID_TIPO_INSTITUICAO=ID_TIPO_INSTITUICAO_1, ID_NOME_INSTITUICAO=ID_NOME_INSTITUICAO_1,
                        FK_COD_IES=FK_COD_IES_1,
                        ID_ESPECIALIZACAO, ID_MESTRADO, ID_DOUTORADO,ID_POS_GRADUACAO_NENHUM )],
             form[,list(FK_COD_DOCENTE, FK_COD_ESTADO=FK_COD_ESTADO_DEND, TP_FORM, FK_COD_ESCOLARIDADE, ID_SITUACAO_CURSO=ID_SITUACAO_CURSO_2,FK_CLASSE_CURSO=FK_CLASSE_CURSO_2, 
                        FK_COD_AREA_OCDE=FK_COD_AREA_OCDE_2, ID_LICENCIATURA=ID_LICENCIATURA_2,ID_COM_PEDAGOGICA=ID_COM_PEDAGOGICA_2, ID_COM_PEDAGOGICA=ID_COM_PEDAGOGICA_2,
                        NU_ANO_INICIO=NU_ANO_INICIO_2, NU_ANO_CONCLUSAO=NU_ANO_CONCLUSAO_2, ID_TIPO_INSTITUICAO=ID_TIPO_INSTITUICAO_2, ID_NOME_INSTITUICAO=ID_NOME_INSTITUICAO_2,
                        FK_COD_IES=FK_COD_IES_2,
                        ID_ESPECIALIZACAO, ID_MESTRADO, ID_DOUTORADO,ID_POS_GRADUACAO_NENHUM)],
             form[,list(FK_COD_DOCENTE, FK_COD_ESTADO=FK_COD_ESTADO_DEND, TP_FORM, FK_COD_ESCOLARIDADE, ID_SITUACAO_CURSO=ID_SITUACAO_CURSO_3,FK_CLASSE_CURSO=FK_CLASSE_CURSO_3, 
                        FK_COD_AREA_OCDE=FK_COD_AREA_OCDE_3, ID_LICENCIATURA=ID_LICENCIATURA_3,ID_COM_PEDAGOGICA=ID_COM_PEDAGOGICA_3, ID_COM_PEDAGOGICA=ID_COM_PEDAGOGICA_3,
                        NU_ANO_INICIO=NU_ANO_INICIO_3, NU_ANO_CONCLUSAO=NU_ANO_CONCLUSAO_3, ID_TIPO_INSTITUICAO=ID_TIPO_INSTITUICAO_3, ID_NOME_INSTITUICAO=ID_NOME_INSTITUICAO_3,
                        FK_COD_IES=FK_COD_IES_3,
                        ID_ESPECIALIZACAO, ID_MESTRADO, ID_DOUTORADO,ID_POS_GRADUACAO_NENHUM)])

form<-form[FK_COD_AREA_OCDE!=""] # retira registo sem código de curso em branco


# insere a formação inicial em novos grupos de licenciaturas e formação
form[FK_COD_AREA_OCDE==fis.code, TP_FORM := "Lic em Física"]
form[FK_COD_AREA_OCDE==mat.code, TP_FORM :="Lic em Matemática"] 
form[FK_COD_AREA_OCDE==cie.code, TP_FORM :="Lic em Ciências"]
form[FK_COD_AREA_OCDE==pedl.code | FK_COD_AREA_OCDE==pedb.code, TP_FORM:="Pedagogia" ]
form[ID_LICENCIATURA==1 &
       FK_COD_AREA_OCDE!=pedl.code & FK_COD_AREA_OCDE!=pedb.code &
       FK_COD_AREA_OCDE!=fis.code & FK_COD_AREA_OCDE!=mat.code &
       FK_COD_AREA_OCDE!=cie.code, TP_FORM:="Outras licenciaturas"] 
form[ID_LICENCIATURA==0, TP_FORM:="Outros cursos"]
form[ID_SITUACAO_CURSO==2, TP_FORM:="Estudante"]

#Inclui sigla dos estados
uf<- read.csv("~/dados/lista_estado.csv", header=TRUE, sep=",")
form<- join (form, uf, by="FK_COD_ESTADO")

# Organiza a informação dos professores por ordem de formação inicial
form.lvl<-c("Lic em Física", "Lic em Ciências", "Lic em Matemática", "Outras licenciaturas", "Pedagogia", "Outros cursos", "Estudante")
form$TP_FORM<- factor(form$TP_FORM, levels=form.lvl)
form<-orderBy(~TP_FORM,data=form)
rm(form.lvl)

# Retira professor duplicado
form.total<-form # Guarda todos os professores
form<- form[!duplicated(form[,FK_COD_DOCENTE]),] 

# Junta informação em doc14
form<-form[,list(FK_COD_DOCENTE, TP_FORM, ID_SITUACAO_CURSO,FK_CLASSE_CURSO,
                 FK_COD_AREA_OCDE, ID_LICENCIATURA, ID_COM_PEDAGOGICA,
                 NU_ANO_INICIO, NU_ANO_CONCLUSAO, ID_TIPO_INSTITUICAO, ID_NOME_INSTITUICAO,
                 FK_COD_IES, UF)]

doc14<-join(doc14,form,by="FK_COD_DOCENTE")

# Restaura form para uso posterior
form<-form.total
form<- form[!duplicated(form[,FK_COD_DOCENTE]),] 
rm(form.total)

### * form é o registo de todos os professores, retiradados os dados
