#' Shiny App for Plotting Mutations on a Single Gene Along its Length
#'
#' @return No return value
#' @export
#'
#'@references
#' Grolemund, G. (2015). Learn Shiny - Video Tutorials. \href{https://shiny.rstudio.com/tutorial/}{Link}
runBinnedPlotSingleGene <- function() {
  appDir <- system.file("shiny-scripts",
                        package = "MutTranscript")
  actionShiny <- shiny::runApp(appDir, display.mode = "normal")
  return(actionShiny)
}
