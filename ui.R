require(shiny)
shinyUI(fluidPage(navbarPage("Canceres", id="nav",
                   tabPanel('Mapas dos Canceres',
                     
                     sidebarPanel(
                       selectInput('cancerm', 'Cancerm', names(Rate3)[-c(1,2)],selected=names(Rate3)[[3]])
                       
                     ),
                     mainPanel(
                       
                       h4("Quantidade"),
                       plotOutput("plot2mapa"),
                       
                       h4("Rate"),
                       plotOutput('plot1mapa'),
                       
                       h4("SMR"),
                       plotOutput("plot3mapa")
                     )
                   ),
                   tabPanel('Descritivas e graficos gerais',
                            img(src="incidencia-de-canceres-analise.jpg", height = "1800px", width = "900px"),
                            p("Os canceres são mostrados em ordem decrescente de frequencia. O cancer mais comum foi o Cancer de mama entre mulheres brancas seguido pelo cancer de prostata entre homens brancos. Isso aparamente contradiz o que se espera, que o cancer de pulmao seja o mais frequente, entretanto o site do SEER aponta que os canceres mais frequentes sao os canceres de prostata e mama, superando mesmo o pulmao."),
                            p("Os cancerese mais frequentes sao em ordem decrescente sao mama entre mulheres brancas, prostata entre homens brancos, pulmao e bronquios entre homens brancos seguidos por mulheres brancas, bexiga entre homens brancso e mama in situ feminino entre mulheres brancas"),
                            img(src="porcentagem-acumulada-da-incidencia-analise.jpg", height = "1800px", width = "900px"),
                            p("Percebemos que 8 canceres sao responsavei por 30% das incidencias. Sao necessarios 50 canceres para termos 90% da incidencia."),
                            img(src="mapa-de-correlacao-analise.jpg", height = "900px", width = "900px"),
                            p("Existe uma alta correlacao entre os canceres como pode-se observar pelo mapa de calor. Existe uma correlacao maior que 0.75 em 942 combinacoes de canceres e ccorrelacao maior que 9 em 68 combinacoes."),
                            img(src="correlacao-entre-os-pares-de-canceres-por-quantidade", height = "1800px", width = "900px"),
                            p("Existe 47 pares de canceres, feminino e masculino para um mesmo cancer em uma mesma raca.Podemos observar que existe um decaimento na correlacao quando a frequencia dos canceres diminui. Entretanto mesmo com esse decaimento apenas 2 pares de canceres apresentaram uma correlacao menor que 0.5, mas ainda assim, maior que 0.4. 19 canceres possuem uma correlacao maior que 0.9 e 30 uma correlacao maior que 0.8. No grafico dos pontos ordenados por correlacao vemos que a correlacao tem um decaimento lento ate o 43 e despenca apartir dele."),
                            img(src="correlacao-entre-os-pares-de-canceres-por-correlacao.jpg"),
                            p("Na proxima aba estao os boxplots para quantidade, taxa bayesiana e SMR de cada cancer.")
                            
                            ),
                   tabPanel('Boxplot dos Canceres',
                    
                     sidebarPanel(
                       selectInput('cancer', 'Cancer', names(Rate3)[-c(1,2)],selected=names(Rate3)[[3]])
                       
                     ),
                     mainPanel(
                       
                       h4("Quantidade"),
                       plotOutput("plot2"),
                       
                       h4("Rate"),
                       plotOutput('plot1'),
                       
                       h4("SMR"),
                       plotOutput("plot3")
                     )
                   ),
                   tabPanel('Grupo dos Canceres',
                     
                     sidebarPanel(
                       numericInput('ngrupo', 'Numero de Grupos', value=2,min=1,max=100,step=1),
                       numericInput('grupo','Grupo de Interesse',value=1,min=1,max=100,step=1),
                       p("Abaixo encontra-se o grafico que mostra o decaimento da soma de quadrados a medida que os grupos sao formados. Para o calculo sao utilizados 1000 repeticoes, devido a semente aleatoria do kmeans"),
                       img(src="soma-dos-quadrados-interna.jpg"),
                       p("Percebemos que nao ha um decaimento rapido e uma estagnacao como seria o desejado. Entretanto percebemos que existe dois comportamentos, o primeiro e um rapido decaimento entre 1 e 7 canceres, apartir do oitavo a velocidade de decaimento começa e diminuir.")
                       
                     ),
                     mainPanel(
                       
                       h4("SMR dos centroides do grupo"),
                       plotOutput("plot1g"),
                       
                       h4("Tabela dos Canceres"),
                       dataTableOutput(outputId="tab1")
                       
                     )
                   )
)))