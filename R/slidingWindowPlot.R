slidingWindowPlot <- function(annotatedVcf, windowSize = 100, stepSize = 50) {
  annotatedVcfDf <- as.data.frame(annotatedVcf, row.names = seq(1, length(codingVcf)))

  slidingCounts <- data.frame()

  maxDist <- max(annotatedVcfDf$CDSLOC.start, na.rm = TRUE)

  for (start in seq(0, maxDist - windowSize, by = stepSize)) {
    end <- start + windowSize

    windowData <- annotatedVcfDf %>%
      filter(CDSLOC.start >= start, CDSLOC.start < end)

    windowCounts <- windowData %>%
      group_by(CONSEQUENCE) %>%
      summarise(count = n(), .groups = 'drop') %>%
      mutate(window_start = start, window_end = end)

    slidingCounts <- rbind(slidingCounts, windowCounts)
  }

  # Create the sliding window plot
  ggplot(slidingCounts, aes(x = (window_start + window_end) / 2, y = count, fill = CONSEQUENCE)) +
    geom_bar(stat = "identity", position = "stack") +
    labs(x = "Distance from 5' End", y = "Variant Count", fill = "Variant Type") +
    theme_minimal()
}

# annotatedVcf <- codingVcf
# windowSize = 100
# stepSize = 50
#
# annotatedVcfDf <- as.data.frame(annotatedVcf, row.names = seq(1, length(codingVcf)))
# # if (!all(c("distance_from_3prime", "variant_type") %in% colnames(vcf_data))) {
# #   stop("vcf_data must contain 'distance_from_3prime' and 'variant_type' columns.")
# # }
# annotatedVcfDf
#
# slidingCounts <- data.frame()
# # colnames(slidingCounts) <- colnames(annotatedVcfDf)
#
# maxDist <- max(annotatedVcfDf$CDSLOC.start, na.rm = TRUE)
# maxDist
#
# for (start in seq(0, maxDist - windowSize, by = stepSize)) {
#   end <- start + windowSize
#
#   windowData <- annotatedVcfDf %>%
#     filter(CDSLOC.start >= 0, CDSLOC.start < 100)
#
#   windowCounts <- windowData %>%
#     group_by(CONSEQUENCE) %>%
#     summarise(count = n(), .groups = 'drop') %>%
#     mutate(window_start = start, window_end = end)
#
#   print(windowCounts)
#   slidingCounts <- rbind(slidingCounts, windowCounts)
# }
#
# slidingCounts
#
# ggplot(slidingCounts, aes(x = (window_start + window_end) / 2, y = count, fill = CONSEQUENCE)) +
#   geom_bar(stat = "identity", position = "stack") +
#   labs(x = "Distance from 5' End", y = "Variant Count", fill = "Variant Type") +
#   theme_minimal()
