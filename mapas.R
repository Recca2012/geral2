require(ggplot2)
require(maps)
require(grid)
require(reshape)

# down<-"https://dl.dropboxusercontent.com/u/77398697/Dissertacao/2014_05_28/dados.RData"
# dest<-file.path(getwd(),"dados-download.RData")
# download.file(down,dest,method="curl")
load(file="data/dados.RData")
load(file="data/clusters.RData")
# unlink(dest)
plotar.mapa<-function(shape,dados,smr=NULL){
  banco.plotar<-merge(shape,dados,by="State")
  names(banco.plotar)[5]<-"Cancer"
  p <- ggplot() + coord_fixed()
  
  
  base_state <- p + geom_polygon(data=banco.plotar,title=(names(dados)[2]),#colour="white",
                                      aes(x=lon,
                                          y=lat,
                                          group=State,fill=Cancer))+ 
    scale_fill_continuous(low="steelblue",high="tomato")+
   # if(sum(smr=="smr")==1){scale_fill_discrete(low="steelblue",high="tomato",breaks=c(0,0.5,0.6,0.7,0.8,0.9,1,1.1,1.2,1.3,1.4,1.5,2,5))}+
    
    theme(legend.position="right",
          panel.background = element_rect(fill = "white"),
          axis.title.x = element_blank(), 
          axis.text.x  = element_blank(),
          axis.title.y = element_blank(), 
          axis.text.y  = element_blank(),
          title =  element_text(size = 14, face = "bold"))
     print(base_state)
}




plotar.grupos<-function(banco,cluster,ngrupo,grupo,shape,smr="smr"){
  grupoplotar<-cluster[[ngrupo]][which(cluster[[ngrupo]]$kmeans==grupo),1]
  bancoplotar<-data.frame("State"=banco[,1],"Cancer"=rowMeans(as.matrix(banco[,which(names(banco) %in% grupoplotar)])))
  plotar.mapa(shape=shape,dados=bancoplotar,smr=smr)
}

plotar.tabela<-function(cluster,ngrupo,grupo){
  grupoplotar<-cluster[[ngrupo]][,c(1,3)]
  names(grupoplotar)<-c("Cancer","Grupo por kmeans")
  rownames(grupoplotar)<-NULL
  print(grupoplotar)

}




# 
# SMR<-Rate3
# 
# 
# for(i in names(Rate3)[-c(1:2)]){
#   SMR[,i]<-NA
#   SMR[,i]<-Rate3[,i]/(sum(Quantidade[which(!is.na(Quantidade[,i])),i])/sum(Pop[which(!is.na(Quantidade[,i])),i]))
# }
# 
# 
# 
# 
# 
# save(Pop,Pop3,Quantidade,Quantidade3,Rate,Rate3,SMR,base,shape,file="~/Dropbox/Dissertacao/reunioes/2014-05-28/mapas/dados.RData")
# SMR$State<-NULL
# names(SMR)[1]<-"State"
