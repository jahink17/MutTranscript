#' Proportion of Variants of a Specific Type Binned by Distance from 5' End
#'
#' This function creates a stacked bar plot showing the distribution of variant
#' counts across bins defined by their distance from the 5' end of the coding
#' sequence. The plot is useful for visualizing how variants are distributed
#' across the coding region and grouped by a user-defined type (e.g. synonymous
#' v nonsynonymous).
#'
#' @param codingVcf A `VCF` object generated using `annotateVCF()` containing
#'   coding variants with metadata, including a `CDSLOC.start` column indicating
#'   the position of the mutation in the coding sequence. Must also contain a
#'   column for the user=defined variant type.
#' @param nBins An integer specifying the number of bins to divide the coding
#'   region into. Default is 10.
#' @param type A string specifying the property to group the variants by in each
#'   stacked barplot.
#'
#' @return A ggplot object displaying the binned distribution of variants by
#'   variant type.
#' @import dplyr
#' @import ggplot2
#' @import BiocGenerics
#' @export
#'
#' @examples
#' \dontrun{
#' annotatedVcf <- annotateCodingVcf(mutationsVcf)
#' binnedByDistancePlot(annotatedVcf, nBins = 10)
#' }
binnedByDistancePlot <- function(codingVcf, nBins = 10, type = "CONSEQUENCE") {
  codingVcfDf <- as.data.frame(codingVcf, row.names = seq(1, length(codingVcf)))
  codingVcfDf$bin <- cut(codingVcfDf$CDSLOC.start, breaks = nBins, labels = FALSE)
  variant_counts <- codingVcfDf %>%
    dplyr::group_by(across(all_of(c("bin", type)))) %>%
    dplyr::summarise(count = n(), .groups = 'drop')
  binnedPlot <- ggplot2::ggplot(variant_counts, aes(x = factor(bin), y = count, fill = .data[[type]])) +
    geom_bar(stat = "identity") +
    labs(x = "Distance from Transcription Start Site", y = "Variant Count", fill = "Variant Type") +
    theme_minimal()
  return(binnedPlot)
}

binnedByDistancePlotV2 <- function(codingVcf, nBins = 10, type = "CONSEQUENCE") {

  codingVcfDf <- as.data.frame(codingVcf, row.names = seq(1, length(codingVcf)))

  codingVcfDf <- calculateNormDistances(codingVcfDf)

  codingVcfDf$bin <- cut(codingVcfDf$normDist, breaks = nBins, labels = FALSE)
  variant_counts <- codingVcfDf %>%
    dplyr::group_by(across(all_of(c("bin", type)))) %>%
    dplyr::summarise(count = n(), .groups = 'drop')
  binnedPlot <- ggplot2::ggplot(variant_counts, aes(x = factor(bin), y = count, fill = .data[[type]])) +
    geom_bar(stat = "identity") +
    labs(x = "Bins from 5' End", y = "Variant Count", fill = "Variant Type") +
    theme_minimal()
  return(binnedPlot)
}

calculateNormDistances <- function(codingVcfDf) {
  transcriptLengths <- GenomicFeatures::transcriptLengths(txdb)
  codingVcfDf$TXIDnum <- as.integer(codingVcfDf$TXID)
  codingVcfDf <- dplyr::left_join(codingVcfDf, transcriptLengths, by = join_by(TXIDnum == tx_id))
  codingVcfDf$normDist <- codingVcfDf$CDSLOC.start / codingVcfDf$width.y
  return(codingVcfDf)
}
