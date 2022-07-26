install.packages(c("shiny","shinythemes"))
library(shiny)
library(shinythemes)


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
      )
    )          
)

server<- function(input, output){
  Pokemon <- read.csv("C:/Users/terra/projects/ColumbiaUniversity/CourseLessonPlans/WebApps/pokemon.csv")
  Pokemon %>% filter(Pokemon$Type.1=="Fire")->fire_pokemon
  Pokemon %>% filter(Pokemon$Type.1=="Water")->water_pokemon
  
  output$firePokemon <- renderPlot({
    ggplot(data = fire_pokemon, aes(x=HP,y=Speed))+geom_point(color="red")
  })
  
  output$waterPokemon <- renderPlot({
    ggplot(data = water_pokemon, aes(x=HP,y=Speed))+geom_point(color="blue")
  })
  
  
  output$txtout <- renderText({
    paste(input$txt1)
  })
}

shinyApp(ui = ui, server = server)

#runExample("01_hello")
