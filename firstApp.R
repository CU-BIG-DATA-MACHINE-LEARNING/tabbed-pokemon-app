install.packages(c("shiny","shinythemes"))
library(shiny)
library(shinythemes)
library(ggplot2)
library(dplyr)
Pokemon <- read.csv("C:/Users/terra/projects/ColumbiaUniversity/CourseLessonPlans/WebApps/pokemon.csv")


ui<- fluidPage(
    theme = shinytheme("cerulean"),
    navbarPage(
      "My Pokemon Charts",
      tabPanel("Fire Type Pokemon",
          sidebarPanel(
            tags$h3("Input:"),
            textInput("txt1","Pokemon Name","")
          ),
       
          mainPanel(
            h1("HP Chart"),
            #verbatimTextOutput("txtout")
            plotOutput(outputId = "firePokemon")
          )    
      ), 
      tabPanel("Water Type Pokemon",
                  sidebarPanel(
                    tags$h3("Input:"),
                    textInput("txt1","Pokemon Name","")
                  ),
                  mainPanel(
                    h1("HP Chart"),
                    #verbatimTextOutput("txtout")
                    plotOutput(outputId = "waterPokemon")
                  )    
      ),
      tabPanel("All Pokemon",
               sidebarPanel(
                 tags$h3("Choose a Type"),
                  selectInput("type", label="Pokemon Type", choices =rownames(table(Pokemon$Type.1)), selected="Fire")#create a list of choices based on pokemon types )
               ),
               mainPanel(
                 h1("HP Chart"),
                 #verbatimTextOutput("txtout")
                 plotOutput(outputId = "allPokemon")
               )    
      )
    )          
)

server<- function(input, output){
  Pokemon %>% filter(Pokemon$Type.1=="Fire")->fire_pokemon
  Pokemon %>% filter(Pokemon$Type.1=="Water")->water_pokemon
 
  
  output$firePokemon <- renderPlot({
    ggplot(data = fire_pokemon, aes(x=HP,y=Speed))+geom_point(color="red")
  })
  
  output$waterPokemon <- renderPlot({
    ggplot(data = water_pokemon, aes(x=HP,y=Speed))+geom_point(color="blue")
  })
  
  output$allPokemon<- renderPlot({
    Pokemon %>% filter(Pokemon$Type.1==input$type)->all_pokemon
    ggplot(data=all_pokemon, aes(x=Attack, y=Defense))+ geom_point(color="orange")
  })
  
  output$txtout <- renderText({
    paste(input$txt1)
  })
}

shinyApp(ui = ui, server = server)

#runExample("01_hello")
