library(shiny)
library(tidyverse)
library(DT) 

data <- read_csv("cleaned_Auschwitz_data_new.csv")

# UI
ui <- fluidPage(
  # Application title
  titlePanel("Number of Holocaust victims killed at Auschwitz"),
  
  # Style Menu
  selectInput("religion", "Religion", c("All", "Jew", "Protestant", "Catholic", "andere", 
                                        "Believes in God", "Greek Catholic", 
                                        "Atheist", 
                                        "Greek Orthodox", 
                                        "Unknown", "Eastern Orthodox", 
                                        "Russian Orthodox", "Jehovah's Witness", 
                                        "Czech-Moravian", 
                                        "Buddhist", "Hussite", "Unaffiliated", 
                                        "Muslim", "Agnostic"
                                  )),
  
  # Bar Chart
  plotOutput("residencebar", width = "100%", height = "800px"),
  
  #Table
  dataTableOutput("table")
  
)

# Define server logic
server <- function(input, output) {
  # Create bar chart of residences
  output$residencebar <- renderPlot({

    # Filter data based on selected Religion
    if (input$religion != "All") {
      data <- filter(data, religion == input$religion)
    }
    
    # Top 25 residences
    residence_data <- group_by(data, residence)|>
      summarise(number = n()) |>
      arrange(desc(number)) |>
      top_n(20)
    
    # Bar chart
    ggplot(residence_data, aes(reorder(residence, number))) +
      geom_bar(aes(weight = number), fill = "tomato3") + 
      coord_flip() +
      ggtitle("Number of Holocaust victims killed at Auschwitz by Residence") +
      xlab("Residence") +
      ylab("Number of Deaths") +
      theme_bw(base_size = 10)
    
  })
    
    # Create data table
    output$table <- renderDataTable({
      
      # Filter data based on selected Style
      if (input$religion != "All") {
        data <- filter(data, religion == input$religion)
      }
      data[1:7]
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)