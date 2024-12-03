# Load required libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)

# source("../../R/binnedByDistancePlot.R")
# source("../../R/annotateCodingVcf.R")

ui <- fluidPage(
  titlePanel("Binned Mutation Types Viewer"),

  sidebarLayout(
    sidebarPanel(
      # fileInput("vcf_file", "Upload VCF File", accept = ".vcf"),
      textInput("gene_name", "Gene Name", value = ""),
      sliderInput("n_bins", "Number of Bins", min = 5, max = 50, value = 10),
      actionButton("plot_btn", "Generate Plot")
    ),

    mainPanel(
      plotOutput("mutation_plot")
    )
  )
)



server <- function(input, output, session) {
  mutation_data <- reactive({
    req(input$vcfFile)  # Ensure file is uploaded

    annotatedVcf <- annotateCodingVcf(mutationsVcf)

    return(annotatedVcf)
  })

  # Generate the plot when the button is clicked
  observeEvent(input$plot_btn, {
    output$mutation_plot <- renderPlot({
      req(mutation_data())  # Ensure data is available
      binnedByDistancePlotSingleGene(annotatedVcf, input$n_bins, type = "CONSEQUENCE")
    })
  })
}

# Run the app
shinyApp(ui = ui, server = server)
