########################################################
#Gráficos da Formação Inicial
########################################################

# Requer form_inicial.R

# Carrega bibliotecas
library("ggplot2")
library("survival")
library("doBy")

form$UF<-factor(form$UF, levels=uf.lvl$UF)
form<-orderBy(~UF, data=form)

# Porcentagem de professores por formação
pform <-ggplot(form, aes(x=UF, fill=TP_FORM)) +
  geom_bar(position="fill", stat="count")+
  #ggtitle("Formação inicial do professores \n de Física por Estado")+
  xlab("Unidade da Federação")+
  ylab("Professores por formação inicial")+
  #geom_hline(yintercept =0.2265, colour="black", linetype = "longdash")+
  guides(fill = guide_legend(reverse=TRUE))+
  scale_fill_brewer(palette="Set2", name="Formação Inicial") + 
  coord_flip()+
  #annotate("text", label = "Média nacional ~ 20%", x = 19, y = .26, size = 4, colour = "black", angle=90)+
  theme_minimal()
pform

# Porcentagem de professores por formação - mudança de cor
pform1 <-ggplot(form, aes(x=UF, fill=ifelse(TP_FORM=="Lic em Física","Com Licencitura em Física", "Sem Licenciatura em Física"))) +
  geom_bar(position="fill", stat="count")+
  #ggtitle("Formação inicial do professores \n de Física por Estado")+
  xlab("Unidade da Federação")+
  ylab("Professores por formação inicial")+
  #geom_hline(yintercept =0.2265, colour="black", linetype = "longdash")+
  guides(fill = guide_legend(reverse=TRUE))+
  scale_fill_manual(values=c("grey20", "grey90"), name="Formação Inicial") + 
  coord_flip()+
  #annotate("text", label = "Média nacional ~ 20%", x = 19, y = .26, size = 4, colour = "black", angle=90)+
  theme_minimal()
pform1

