#' Number of Variants of a Specific Type Binned by Normalized Distance from 5' End
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
#'   column for the user-defined variant type.
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
#' @import TxDb.Hsapiens.UCSC.hg19.knownGene
#' @export
#'
#' @examples
#' \dontrun{
#' annotatedVcf <- annotateCodingVcf(mutationsVcf)
#' binnedByDistancePlotV2(annotatedVcf, nBins = 10)
#' }
binnedByDistancePlotV2 <- function(codingVcf, nBins = 10, type = "CONSEQUENCE") {

  codingVcfDf <- as.data.frame(codingVcf, row.names = seq(1, length(codingVcf)))

  # codingVcfDf <- calculateNormDistances(codingVcfDf)

  # codingVcfDf$bin <- cut(codingVcfDf$normDist, breaks = nBins, labels = FALSE)
  # variant_counts <- codingVcfDf %>%
  #   dplyr::group_by(across(all_of(c("bin", type)))) %>%
  #   dplyr::summarise(count = n(), .groups = 'drop')
  # binnedPlot <- ggplot2::ggplot(variant_counts, aes(x = factor(bin), y = count, fill = .data[[type]])) +
  #   geom_bar(stat = "identity") +
  #   labs(x = "Bins from 5' End", y = "Variant Count", fill = "Variant Type") +
  #   theme_minimal()
  # return(binnedPlot)
  binnedPlot <- generateBinnedPlotV2(codingVcfDf, nBins,  type)
  return(binnedPlot)
}

#' Number of Variants of a Specific Type in a Single Gene Binned by Normalized Distance from 5' End
#'
#' This function creates a bar plot showing the distribution of variant
#' counts across bins grouped by their distance from the 5' end of the coding
#' sequence. The plot is useful for visualizing how variants are distributed
#' across the coding region and grouped by a user-defined type (e.g. synonymous
#' v nonsynonymous).
#'
#' @param codingVcf A `VCF` object generated using `annotateVCF()` containing
#'   coding variants with metadata, including a `CDSLOC.start` column indicating
#'   the position of the mutation in the coding sequence. Must also contain a
#'   column for the user-defined variant type.
#' @param geneID ID of the gene of interest. Must be a valid gene ID present in the VCF file.
#' @param nBins An integer specifying the number of bins to divide the coding
#'   region into. Default is 10.
#' @param type A string specifying the property to group the variants by in each
#'   stacked barplot.
#'
#' @return A bar plot showing the distribution of variant
#' counts across bins grouped by their distance from the 5' end of the coding
#' sequence.
#' @export
binnedByDistancePlotSingleGene <- function(codingVcf, geneID, nBins = 10, type = "CONSEQUENCE") {
  codingVcfDf <- as.data.frame(codingVcf, row.names = seq(1, length(codingVcf)))

  codingVcfDfGene <- codingVcfDf[codingVcfDf$GENEID == geneID & !is.na(codingVcfDf$GENEID),]

  binnedPlot <- generateBinnedPlotV2(codingVcfDfGene, nBins, type)
  return(binnedPlot)
}

# OLD VERSION
# generateBinnedPlot <- function(codingVcfDf, nBins, type = "CONSEQUENCE") {
#   codingVcfDf <- calculateNormDistances(codingVcfDf)
#
#   codingVcfDf$bin <- cut(codingVcfDf$normDist, breaks = nBins, labels = FALSE)
#   variant_counts <- codingVcfDf %>%
#     dplyr::group_by(across(all_of(c("bin", type)))) %>%
#     dplyr::summarise(count = n(), .groups = 'drop')
#   binnedPlot <- ggplot2::ggplot(variant_counts, aes(x = factor(bin), y = count, fill = .data[[type]])) +
#     geom_bar(stat = "identity") +
#     labs(x = "Bins from 5' End", y = "Variant Count", fill = "Variant Type") +
#     theme_minimal()
#   return(binnedPlot)
# }

#' Generating Plot of Mutation Data Binned by Distance from Start Site
#'
#' @param codingVcfDf A `VCF` object generated using `annotateVCF()` containing
#'   coding variants with metadata, including a `CDSLOC.start` column indicating
#'   the position of the mutation in the coding sequence. Must also contain a
#'   column for the user-defined variant type.
#' @param nBins An integer specifying the number of bins to divide the coding
#'   region into. Default is 10.
#' @param type A string specifying the property to group the variants by in each
#'   stacked barplot.
#'
#' @return A bar plot showing the distribution of variant
#' counts across bins grouped by their distance from the 5' end of the coding
#' sequence.
generateBinnedPlotV2 <- function(codingVcfDf, nBins, type = "CONSEQUENCE") {
  codingVcfDf <- calculateNormDistances(codingVcfDf)

  codingVcfDf <- codingVcfDf %>%
  mutate(Bin = cut(normDist, breaks = nBins, labels = FALSE))

  allCombinations <- expand.grid(
    Bin = 1:nBins,
    CONSEQUENCE = unique(codingVcfDf$CONSEQUENCE)
    )

  # Summarize counts of each Consequence within each bin and include empty bins
  summaryData <- codingVcfDf %>%
    group_by(Bin, CONSEQUENCE) %>%
    summarize(Count = n(), .groups = "drop") %>%
    right_join(all_combinations, by = c("Bin", "CONSEQUENCE")) %>%
    tidyr::replace_na(list(Count = 0))  # Fill missing counts with 0

  # Plot the data
  binnedPlot <- ggplot(summaryData, aes(x = as.factor(Bin), y = Count, fill = CONSEQUENCE)) +
    geom_bar(stat = "identity", position = "dodge") +
    scale_fill_brewer(palette = "Set2") +
    labs(
      x = "Distance Bins",
      y = "Count",
      fill = "Mutation Type",
      title = "Binned Mutation Types by Distance"
    ) +
    theme_minimal()
  return(binnedPlot)
}

#' Calculating Normalized Distances for Mutations
#'
#' @param codingVcfDf
#'
#' @return A dataframe containing added columns with transcript length and normalized mutation distance.
#' @export
calculateNormDistances <- function(codingVcfDf) {
  txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
  transcriptLengths <- GenomicFeatures::transcriptLengths(txdb)
  codingVcfDf$TXIDnum <- as.integer(codingVcfDf$TXID)
  codingVcfDf <- dplyr::left_join(codingVcfDf, transcriptLengths, by = join_by(TXIDnum == tx_id))
  codingVcfDf$normDist <- codingVcfDf$CDSLOC.start / codingVcfDf$tx_len
  return(codingVcfDf)
}



# OLD VERSION
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
#'   column for the user-defined variant type.
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
#' @import TxDb.Hsapiens.UCSC.hg19.knownGene
#' @export
#'
#' @examples
#' \dontrun{
#' annotatedVcf <- annotateCodingVcf(mutationsVcf)
#' binnedByDistancePlot(annotatedVcf, nBins = 10)
#' }
# binnedByDistancePlot <- function(codingVcf, nBins = 10, type = "CONSEQUENCE") {
#   codingVcfDf <- as.data.frame(codingVcf, row.names = seq(1, length(codingVcf)))
#   codingVcfDf$bin <- cut(codingVcfDf$CDSLOC.start, breaks = nBins, labels = FALSE)
#   variant_counts <- codingVcfDf %>%
#     dplyr::group_by(across(all_of(c("bin", type)))) %>%
#     dplyr::summarise(count = n(), .groups = 'drop')
#   binnedPlot <- ggplot2::ggplot(variant_counts, aes(x = factor(bin), y = count, fill = .data[[type]])) +
#     geom_bar(stat = "identity") +
#     labs(x = "Distance from Transcription Start Site", y = "Variant Count", fill = "Variant Type") +
#     theme_minimal()
#   return(binnedPlot)
# }

# [END]
