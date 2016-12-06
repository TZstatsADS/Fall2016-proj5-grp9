#local
library(shiny)
library(ggplot2)
library(plotly)
# Define UI for application that draws 4 pages
shinyUI(navbarPage(id="navbar",title="Movie Poster Designer",
                   theme="grey.css",
                   tabPanel("Introduction",
                            titlePanel(h1("Introduction")),
                            mainPanel(tabPanel("Introduction",includeMarkdown("introduction.md")),
                                      img(src='contrast.jpg', align = "right"))
                   ),
                   tabPanel("EDA",
                            titlePanel(h1("EDA"))),
                   tabPanel("Face and Text Detection",
                            titlePanel(h1("Face Detection"))),
                   tabPanel("Box Prediction",
                            titlePanel(h1("Box Prediction"))),
                            
                            
                            tabPanel("Reference and Contact",
                                     titlePanel(h2("Contact")),
                                     mainPanel(tabPanel("Contact",includeMarkdown("contact.md"))
                                                          
                            ))))

