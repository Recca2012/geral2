palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
require(RCurl)
#source(getURL("https://raw.githubusercontent.com/Recca2012/mapas/master/mapas.R"))
u <- "https://raw.githubusercontent.com/Recca2012/geral/master/mapas.R"
script <- getURL(u, ssl.verifypeer = FALSE)
eval(parse(text = script))
u2 <- "https://raw.githubusercontent.com/Recca2012/descritivas/master/descritivias.R"
script2 <- getURL(u2, ssl.verifypeer = FALSE)
eval(parse(text = script2))
load("data/dados.RData",envir=.GlobalEnv)
shinyServer(function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  dadoratem <- reactive({
    Rate3[,c("State",input$cancerm)]
    
  })
  dadoquanm <- reactive({
    Quantidade3[,c("State",input$cancerm)]
    
  })
  dadosmrm <- reactive({
    SMR[,c("State",input$cancerm)]
    
  })
  shape2<-reactive({shape})
  output$plot1mapa <- renderPlot({
    plotar.mapa(shape=shape2(),dados=dadoratem())
  })
  output$plot2mapa<-renderPlot({
    plotar.mapa(shape=shape2(),dados=dadoquanm())
    
  })
  output$plot3mapa<-renderPlot({
    plotar.mapa(shape=shape2(),dados=dadosmrm(),smr="smr")
    
  })
  
  
  dadorate <- reactive({
    Rate3[,c("State",input$cancer)]
    
  })
  dadoquan <- reactive({
    Quantidade3[,c("State",input$cancer)]
    
  })
  dadosmr <- reactive({
    SMR[,c("State",input$cancer)]
    
  })
  shape2<-reactive({shape})
  output$plot1 <- renderPlot({
    plotar.boxplot(dados=dadorate(),tipo="Rate")
  })
  output$plot2<-renderPlot({
    plotar.boxplot(dados=dadoquan(),tipo="Quantidade")
    
  })
  output$plot3<-renderPlot({
    plotar.boxplot(dados=dadosmr(),tipo="SMR")
    
  })
  
  
  dados2<-reactive({SMR})
  banco.grupos2<-reactive({banco.grupos2})
  
  output$plot1g <- renderPlot({
    plotar.grupos(banco=dados2(),cluster=banco.grupos,ngrupo=input$ngrupo,grupo=input$grupo,shape=shape2(),smr="smr")
  })
  
  output$tab1<-renderDataTable({
    plotar.tabela(cluster=banco.grupos,ngrupo=input$ngrupo,grupo=input$grupo)
  })
})