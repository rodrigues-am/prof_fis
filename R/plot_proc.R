###################################
### Gráfico matricula por professor de Física
### Censo escolar - 2015
##################################

# Carrega bibliotecas
library(dplyr)
library(ggplot2)
library(ggthemes)

# Carrega dados com matriculas no ensino médio por UF
mat.em15 <- read.csv ("~/R/surdos/mat.em15.csv", sep=",", header = TRUE)

# Insere dados sobre os licenciados e professores de Física
mat.em15 <- mat.em15 %>%
  tbl_df() %>%
  rename(FK_COD_ESTADO=CO_UF, mat=N) %>%
  left_join(.,uf, by="FK_COD_ESTADO") %>%
  left_join(.,select(es15,UF,N), by="UF") %>%
  rename(prof=N) %>%
  left_join(., filter(form.es15, TP_FORM=="Lic em Física")) %>%
  rename(fis=N, fis_p=Proc) %>%
  mutate(Pmat=prof/mat, Lmat=fis/mat) %>%
  arrange(Pmat)

# Organiza os dados para o gráfico
mat.em15$UF <- factor(mat.em15$UF, levels=mat.em15$UF)

# Porcentagem de professor de Física por matriculas no EM
p4 <-ggplot(mat.em15, aes(x=UF,  y=Pmat*1000)) +
  geom_bar(stat="identity", alpha=.7, fill="steelblue")+
  geom_point(aes(y=Lmat*1000 ), color="white", fill="black" , size=4, shape=21, alpha=1)+
  theme_tufte(base_family="Helvetica")+
  ggtitle("Professores de Física e licenciados em Física \npara cada mil matrículas no Ensino Médio \npor Unidade da Federação \n")+
  xlab(NULL)+
  ylab(NULL)+
  geom_text(aes(label=round(Pmat*1000, digits=2), y=(Pmat*1000)+0.1), hjust=0, color="black")+
  geom_text(aes(label=round(Lmat*1000, digits=2), y=(Lmat*1000)+0.1), hjust=0, color="white")+
  guides(legend.position="bottom")+
  scale_fill_brewer(palette="Set2")+ 
  geom_point(aes(x=4, y=7.5), fill="steelblue", color="steelblue", size=4, shape=22, alpha=.7)+
  geom_point(aes(x=3, y=7.5), fill="black" , size=4, shape=21, alpha=.7)+
  annotate("text", x=4, y=6, hjust=0, label = "Professores de Física")+
  annotate("text", x=3, y=6,hjust=0, label = "Licenciados em Física")+
  coord_flip()+
  theme(axis.ticks=element_blank())
p4
