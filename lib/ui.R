#local
library(shiny)
library(ggplot2)
library(plotly)
# Define UI for application that draws 4 pages
shinyUI(navbarPage(id="navbar",title="Movie Poster Designer",
                   theme="grey.css",
                   tabPanel("Introduction",
                            h3("Hit Features of Movie Poster Designer:"),
                            fluidPage( 
                                fluidRow(
                                    column(3, h4('1. Poster Exploration')),
                                    column(3, h4('2. Face/Text Detection')),
                                    column(3, h4('3. Movie Genre Predition')),
                                    column(3, h4('4. Box Office Predition'))
                                        ),
                                fluidRow(
                                  column(3, 
                                         h5('   Learn the movie/movie poster trend in the past five years!')),
                                  column(3, 
                                         h5('   Is your poster easy-to-read?')),
                                  column(3, 
                                         h5('   How will a poster viewer perceive your poster?')),
                                  column(3,  
                                         h5('   Will your movie be a big success?'))
                                ),
                                fluidRow(
                                  column(3, 
                                         img(src='posters.png',
                                             width = 220, height=350)
                                  ),
                                  column(3, 
                                         img(src='face_detection.jpg',
                                             width = 220, height=350)),
                                  column(3, 
                                         img(src='brain.png',
                                             width = 220, height=350)),
                                  column(3, 
                                         img(src='theaters.png',
                                             width = 220, height=350))
                                )
                                      )
                   ),
                   tabPanel("EDA",
                            tabsetPanel(
                              tabPanel("Barchart of Gross in Genre",
                                       sidebarLayout(
                                         sidebarPanel(
                                           selectInput("s_movie_year", 
                                                       label="Choose a Year to Display",
                                                       choices=c("2011","2012","2013","2014","2015"))
                                         ),
                                         mainPanel(
                                           plotlyOutput("ggBarPlotA",height="500px",width = "600px")
                                         ))),
                              tabPanel("Piechart of Genre",
                                       sidebarLayout(
                                         sidebarPanel(
                                           selectInput("s_movie_year2", 
                                                       label="Choose a Year to Display",
                                                       choices=c("2011","2012","2013","2014","2015"))),
                                         mainPanel(plotlyOutput("ggPiePlot",height="500px",width = "500px")
                                         ))),
                              tabPanel("Bubble Plot of Face",
                                       sidebarLayout(
                                         sidebarPanel(
                                           selectInput("s_movie_year4", 
                                                       label="Choose a Year to Display",
                                                       choices=c("2011","2012","2013","2014","2015"))),
                                         mainPanel(plotlyOutput("BubblePlot",height="500px",width = "600px")
                                         ))),
                              tabPanel("Color Plot in Genre",
                                       sidebarLayout(
                                         sidebarPanel(
                                           selectInput("s_movie_genre3", 
                                                       label="Choose a Genre to Display",
                                                       choices=c("Action","Adventure","Animation","Biography","Comedy",
                                                                 "Crime","Documentary","Drama","Family","Fantacy",
                                                                 "History","Horror","Music","Mystery","Romance",
                                                                 "Sci_Fi","Sport","Thriller","War","Western")
                                           )
                                         ),
                                         mainPanel(
                                           plotlyOutput("ggLinePlot",height="500px",width = "600px")
                                         ))))),
                   
                   tabPanel("Face and Text Detection",
                            titlePanel(h1("Face Detection"))
                            ),
        
                   tabPanel("Genre Prediction",
                            #titlePanel(h3("Genre Prediction")),
                            sidebarPanel(fileInput('x_file', 'Choose a poster to upload',
                                                accept = c('image/jpg', '.jpg')),
                                         imageOutput('x_image',width = 280, height = 400),
                                         actionButton('x_start_analyze', 'Start Analyze'),
                                         textOutput('x_analyze_progess')),
                            mainPanel(
                             tabsetPanel(
                              tabPanel('Predict the genres',
                                       tableOutput('x_prediction')), 
                              tabPanel('Most similar posters', 
                                       fluidPage(
                                         fluidRow(
                                           column(6, h4("Find similar posters")),
                                           column(6, actionButton('x_find_similar', 'Confirm'))
                                         ),
                                         fluidRow(
                                           column(4, h5(textOutput('x_sim1_genres'))),
                                           column(4, h5(textOutput('x_sim2_genres'))),
                                           column(4, h5(textOutput('x_sim3_genres')))
                                         ),
                                         fluidRow(
                                           column(4, imageOutput('x_sim1')),
                                           column(4, imageOutput('x_sim2')),
                                           column(4, imageOutput('x_sim3'))
                                         ),
                                         fluidRow(
                                           column(4, h5(textOutput('x_sim4_genres'))),
                                           column(4, h5(textOutput('x_sim5_genres'))),
                                           column(4, h5(textOutput('x_sim6_genres')))
                                         ),
                                         fluidRow(
                                           column(4, imageOutput('x_sim4')),
                                           column(4, imageOutput('x_sim5')),
                                           column(4, imageOutput('x_sim6'))
                                         )
                                         )
                                       ),
                              tabPanel('Box office winners',
                                       fluidPage(
                                         fluidRow(
                                           fluidRow(column(12, h4("Real genres of your movie:"))),
                                           fluidRow(
                                             column(4, offset=1, selectInput("x_select_genre1", 
                                                                   "Please select genre 1", 
                                                                   choices = c("Action","Adventure","Animation","Biography","Comedy","Crime",
                                                                               "Documentary","Drama","Family","Fantasy","Fil-Noir",
                                                                               "History","Horror","Music","Mystery","Romance","Sci-Fi",
                                                                               "Sport","Thriller","War","Western"), 
                                                                   selected = 'Action', multiple = FALSE,
                                                                   selectize = TRUE, width = NULL, size = NULL)),
                                             column(4, offset=1, selectInput("x_select_genre2", 
                                                                  "Please select genre 2", 
                                                                  choices = c("Action","Adventure","Animation","Biography","Comedy","Crime",
                                                                              "Documentary","Drama","Family","Fantasy","Fil-Noir",
                                                                              "History","Horror","Music","Mystery","Romance","Sci-Fi",
                                                                              "Sport","Thriller","War","Western"), 
                                                                   selected = FALSE, multiple = FALSE,
                                                                   selectize = TRUE, width = NULL, size = NULL)),
                                             column(2, actionButton('x_find_recommend', 'Confirm')))
                                         )
                                        ),
                                       fluidPage(
                                         fluidRow(column(12, h4("Successful posters:"))),
                                         fluidRow(
                                           column(4, imageOutput('x_rec1')),
                                           column(4, imageOutput('x_rec2')),
                                           column(4, imageOutput('x_rec3'))
                                         ),
                                         fluidRow(
                                           column(4, imageOutput('x_rec4')),
                                           column(4, imageOutput('x_rec5')),
                                           column(4, imageOutput('x_rec6'))
                                         )
                                       )
                                       )
                              )# end of tabset
                             ) # end of main
                            ), #end of tab
                            
                   tabPanel("Box Prediction",
                            titlePanel(h1("Box Prediction"))),
                            
                          
                   tabPanel("Reference and Contact",
                            titlePanel(h2("Contact")),
                            mainPanel(tabPanel("Contact",includeMarkdown("contact.md"))
                                                          
                            ))))

