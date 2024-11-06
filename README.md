
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

Although there are already many existing tools to annotate mutation data
from sequencing, some of which this package relies on, no package exists
for the specific purpose of visualizing mutation property distribution
and how it varies with the distance along genes. This information can be
relevant for, for example, uncovering biological effects such as
mutation bias on particular ends of genes or technical effects such as
bias towards the 3’ or 5’ ends of genes in particular RNA sequencing
platforms. Therefore, we hope that this package will enable exploratory
analysis of such effects and thus guide further downstream analysis of
mutation data.

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

## Overview

## Contributions

## References

``` r
ls("package:<PackageName>")
data(package = "<PackageName>") # optional
browseVignettes("<PackageName>")
```

## Acknowledgements

This package was developed as part of an assessment for 2024 BCB410H:
Applied Bioinformatics course at the University of Toronto, Toronto,
CANADA. `MutTranscript` welcomes issues, enhancement requests, and other
contributions. To submit an issue, use the GitHub issues.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(MutTranscript)
#> Warning: replacing previous import 'VariantAnnotation::select' by
#> 'dplyr::select' when loading 'MutTranscript'
#> Warning: replacing previous import 'GenomeInfoDb::intersect' by
#> 'dplyr::intersect' when loading 'MutTranscript'
#> Warning: replacing previous import 'BiocGenerics::union' by 'dplyr::union' when
#> loading 'MutTranscript'
#> Warning: replacing previous import 'BiocGenerics::combine' by 'dplyr::combine'
#> when loading 'MutTranscript'
#> Warning: replacing previous import 'BiocGenerics::setdiff' by 'dplyr::setdiff'
#> when loading 'MutTranscript'
#> Warning: replacing previous import 'BiocGenerics::Position' by
#> 'ggplot2::Position' when loading 'MutTranscript'
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
