
<!-- README.md is generated from README.Rmd. Please edit that file -->

# MutTranscript

Analyzing Transcript-level Properties of Mutation Data in VCF Files

<!-- badges: start -->
<!-- badges: end -->

## Description

The tool will allow users to analyze mutation data from variant call
format (VCF) files. The purpose of this tool is to streamline the
analysis of transcription-related effects of mutations, such as
analyzing whether the mutations are synonymous or nonsynonymous at the
amino acid level, whether they have any deleterious effects and so on.
The tool also enables the visualization of mutations in exonic regions,
allowing the exploration of how these transcription-related effects vary
along the length of a gene. It has the functionality to map the genomic
location of mutations to their location on the coding sequence (CDS) of
the transcript, with the introns removed.

This R package extends existing functionality for the analysis of
mutations stored in VCF files. Although many tools exist for the
analysis of mutations, there are none to the best of my knowledge that
provides a streamlined workflow for the visual exploration of coding
sequence mutations and their effects on the protein product. This tool
aims to fill that gap in existing software, as well as also provide
functionality to map these mutation properties along the length of a
gene to see where specific kinds of mutations localize on the gene. This
information can be relevant for, for example, uncovering biological
effects such as mutation bias on particular ends of genes or technical
effects such as bias towards the 3’ or 5’ ends of genes in particular
RNA sequencing platforms. Therefore, we hope that this package will
enable exploratory analysis of such effects and thus guide further
downstream analysis of mutation data.

This package was built using R version 4.4.2 on an
aarch64-apple-darwin20 platform, running under macOS Ventura 13.2.1.

## Installation

You can install the development version of MutTranscript like so:

``` r
install.packages("devtools")
library("devtools")
devtools::install_github("jahink17/MutTranscript", build_vignettes = TRUE)
library("MutTranscript")
```

To run the Shiny app:

``` r
runBinnedPlotSingleGene()
```

## Overview

``` r
ls("package:<PackageName>")
data(package = "<PackageName>") # optional
browseVignettes("<PackageName>")
```

## Contributions

The functions were contributed by Jahin Kabir, with help from the
packages cited below. Minimal help was used from GenAI, with the
`binnedByDistancePlot()` function, to get help with binning the
mutations by distance. AI was also used to assist with building the
Shiny app, and the code output from GenAI was modified by Jahin Kabir.

## References

R Core Team (2021). R: A language and environment for statistical
computing. R Foundation for Statistical Computing, Vienna, Austria. URL
<https://www.R-project.org/>.

Huber, W., Carey, J. V, Gentleman, R., Anders, S., Carlson, M.,
Carvalho, S. B, Bravo, C. H, Davis, S., Gatto, L., Girke, T., Gottardo,
R., Hahne, F., Hansen, D. K, Irizarry, A. R, Lawrence, M., Love, I. M,
MacDonald, J., Obenchain, V., Ole’s, K. A, Pag’es, H., Reyes, A.,
Shannon, P., Smyth, K. G, Tenenbaum, D., Waldron, L., Morgan, M. (2015).
“Orchestrating high-throughput genomic analysis with Bioconductor.”
Nature Methods, 12(2), 115–121.
<http://www.nature.com/nmeth/journal/v12/n2/full/nmeth.3252.html>.

Pagès H (2024). BSgenome: Software infrastructure for efficient
representation of full genomes and their SNPs. R package version 1.74.0,
<https://bioconductor.org/packages/BSgenome>.

Lawrence M, Huber W, Pagès H, Aboyoun P, Carlson M, Gentleman R, Morgan
M, Carey V (2013). “Software for Computing and Annotating Genomic
Ranges.” PLoS Computational Biology, 9.
<doi:10.1371/journal.pcbi.1003118>,
<http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1003118>.

Obenchain V, Lawrence M, Carey V, Gogarten S, Shannon P, Morgan M
(2014). “VariantAnnotation: a Bioconductor package for exploration and
annotation of genetic variants.” Bioinformatics, 30(14), 2076-2078.
<doi:10.1093/bioinformatics/btu168>.

Wickham H, François R, Henry L, Müller K, Vaughan D (2023). dplyr: A
Grammar of Data Manipulation. R package version 1.1.4,
<https://github.com/tidyverse/dplyr>, <https://dplyr.tidyverse.org>.

Wickham H (2016). ggplot2: Elegant Graphics for Data Analysis.
Springer-Verlag New York. ISBN 978-3-319-24277-4,
<https://ggplot2.tidyverse.org>.

## Acknowledgements

This package was developed as part of an assessment for 2024 BCB410H:
Applied Bioinformatics course at the University of Toronto, Toronto,
CANADA. `MutTranscript` welcomes issues, enhancement requests, and other
contributions. To submit an issue, use the GitHub issues.
