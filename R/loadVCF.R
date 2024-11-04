# To-do: Need to check if this works on test file
# To-do: Need to add functionality to create index file if not present
# To-do: Need to extend to hg38
#' Load a VCF file into R
#'
#' This function loads a VCF (Variant Call Format) file, specified by the file path, into R using the `VariantAnnotation` package.
#' It returns a VCF object, which can be further used for variant analysis.
#'
#' @param pathToVcf A string representing the file path to the VCF file.
#' @param genome A string specifying the reference genome version (e.g. "hg19")
#'
#' @return A `VCF` object containing the variants from the VCF file.
#' @import VariantAnnotation
#' @export
#'
#' @examples
#' \dontrun{
#' vcfData <- loadVCF("/path/to/file.vcf", "hg19")
#' }
loadVcf <- function(pathToVcf, genome) {
  vcfFile <- VariantAnnotation::VcfFile(pathToVcf, index = paste(pathToVcf, "tbi", sep="."))
  vcf <- VariantAnnotation::readVcf(vcfFile, genome = "hg19")
  return(vcf)
}
