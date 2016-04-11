##############################################
### Organiza formação inicial dos professores
### Censo Escolar - 2015
##############################################

# Carrega bibliotecas
library(dplyr) # manipulação de dados

# A variavel doc15 é a compilação do Censo escolar considerando professores em atividade e que lecionam Física

# Insere ordem dos níveis de formação inicial, usado posteriormente para organizar TP_FORM
form.lvl<-c("Lic em Física", "Lic em Ciências", "Lic em Matemática", 
            "Outras licenciaturas", "Pedagogia", "Outros cursos", "Estudante")

form15 <- tbl_df(doc15) # transforma em table_data frame função do dplry

# Cria e roganiza a variavel TP_FORM para formação incial
form15 <- rbind(select(form15, CO_PESSOA_FISICA,FK_COD_ESTADO=CO_UF_END, IN_ESPECIALIZACAO, IN_MESTRADO, IN_DOUTORADO, IN_POS_NENHUM, TP_ESCOLARIDADE,
                       TP_SITUACAO_CURSO=TP_SITUACAO_CURSO_1, CO_CURSO=CO_CURSO_1, CO_CURSO=CO_CURSO_1, IN_LICENCIATURA=IN_LICENCIATURA_1,
                       IN_COM_PEDAGOGICA=IN_COM_PEDAGOGICA_1, NU_ANO_INICIO=NU_ANO_INICIO_1, NU_ANO_CONCLUSAO=NU_ANO_CONCLUSAO_1,
                       TP_TIPO_IES=TP_TIPO_IES_1, NO_IES_CURSO=NO_IES_CURSO_1, CO_IES=CO_IES_1),                
                select(form15, CO_PESSOA_FISICA,FK_COD_ESTADO=CO_UF_END, IN_ESPECIALIZACAO, IN_MESTRADO, IN_DOUTORADO, IN_POS_NENHUM, TP_ESCOLARIDADE,
                       TP_SITUACAO_CURSO=TP_SITUACAO_CURSO_2, CO_CURSO=CO_CURSO_2, CO_CURSO=CO_CURSO_2, IN_LICENCIATURA=IN_LICENCIATURA_2,
                       IN_COM_PEDAGOGICA=IN_COM_PEDAGOGICA_2, NU_ANO_INICIO=NU_ANO_INICIO_2, NU_ANO_CONCLUSAO=NU_ANO_CONCLUSAO_2,
                       TP_TIPO_IES=TP_TIPO_IES_2, NO_IES_CURSO=NO_IES_CURSO_2, CO_IES=CO_IES_2),
                select(form15, CO_PESSOA_FISICA,FK_COD_ESTADO=CO_UF_END, IN_ESPECIALIZACAO, IN_MESTRADO, IN_DOUTORADO, IN_POS_NENHUM, TP_ESCOLARIDADE,
                       TP_SITUACAO_CURSO=TP_SITUACAO_CURSO_3, CO_CURSO=CO_CURSO_3, CO_CURSO=CO_CURSO_3, IN_LICENCIATURA=IN_LICENCIATURA_3,
                       IN_COM_PEDAGOGICA=IN_COM_PEDAGOGICA_3, NU_ANO_INICIO=NU_ANO_INICIO_3, NU_ANO_CONCLUSAO=NU_ANO_CONCLUSAO_3,
                       TP_TIPO_IES=TP_TIPO_IES_3, NO_IES_CURSO=NO_IES_CURSO_3, CO_IES=CO_IES_3) ) %>%
  mutate(TP_FORM=as.factor(ifelse(CO_CURSO==fis.code & TP_SITUACAO_CURSO!=2, "Lic em Física", 
                         ifelse(CO_CURSO==mat.code & TP_SITUACAO_CURSO!=2,"Lic em Matemática", 
                               ifelse(CO_CURSO==cie.code & TP_SITUACAO_CURSO!=2, "Lic em Ciências",
                                     ifelse((CO_CURSO==pedl.code | CO_CURSO==pedb.code) & TP_SITUACAO_CURSO!=2, "Pedagogia",
                                            ifelse(IN_LICENCIATURA==1 &
                                                      CO_CURSO!=pedl.code & CO_CURSO!=pedb.code &
                                                      CO_CURSO!=fis.code & CO_CURSO!=mat.code &
                                                      CO_CURSO!=cie.code  & TP_SITUACAO_CURSO!=2, "Outras licenciaturas",
                                                    ifelse(IN_LICENCIATURA==0  & TP_SITUACAO_CURSO!=2, "Outros cursos",
                                                           ifelse(TP_SITUACAO_CURSO==2, "Estudante", NA))))))))) %>%
  filter(CO_CURSO!="") %>% # retira valores de formação inicial em branco
  mutate(TP_FORM=factor(TP_FORM, levels=form.lvl)) %>% # organiza levels
  arrange(TP_FORM) %>% # organiza dados
  distinct(CO_PESSOA_FISICA) # separa dados para professores únicos
  
form15<- tbl_df(join (form15, uf, by="FK_COD_ESTADO")) # junta com variaveis do estado UF

# Junta dados de formação inicial com a df original doc15
doc15 <- join (doc15, 
              select(form15, CO_PESSOA_FISICA, TP_FORM, UF,TP_SITUACAO_CURSO, CO_CURSO, CO_CURSO, IN_LICENCIATURA,
                     IN_COM_PEDAGOGICA, NU_ANO_INICIO, NU_ANO_CONCLUSAO, TP_TIPO_IES, NO_IES_CURSO, CO_IES), 
              by="CO_PESSOA_FISICA")

doc15 <- tbl_df(doc15)

# Nota: como produto temos form15 (arquivo compacto) e doc15 com todos os professores de Física e sua formação inicial

