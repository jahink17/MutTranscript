#' Title
#'
#' @param codingVcf
#' @param nBins
#'
#' @return
#' @export
#'
#' @examples
binnedByDistancePlot <- function(codingVcf, nBins = 10) {
  codingVcfDf <- as.data.frame(codingVcf, row.names = seq(1, length(codingVcf)))
  codingVcfDf$bin <- cut(codingVcfDf$CDSLOC.start, breaks = nBins, labels = FALSE)
  variant_counts <- codingVcfDf %>%
    dplyr::group_by(bin, CONSEQUENCE) %>%
    dplyr::summarise(count = n(), .groups = 'drop')
  ggplot2::ggplot(variant_counts, aes(x = factor(bin), y = count, fill = CONSEQUENCE)) +
    geom_bar(stat = "identity") +
    labs(x = "Bins from 5' End", y = "Variant Count", fill = "Variant Type") +
    theme_minimal()
}
