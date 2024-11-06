# To-do: Need to check if this works on test file
# To-do: Need to add functionality to create index file if not present
# To-do: Need to extend to hg38
#' Load a VCF file into R
#'
#' A function that loads a VCF (Variant Call Format) file, specified by the file path, into R.
#' It returns a VCF object, which can be further used for variant analysis.
#'
#' @param pathToVcf A string representing the file path to the VCF file. The VCF file must have mutations aligned using the hg19 reference genome; other genomes are not supported at the moment.
#' @param genome A string specifying the reference genome version (e.g. "hg19") (Note: right now, this is the only version that is supported. Additional functionality for supporting other genome types will be added in the future.)
#'
#' @return A `VCF` object containing the variants from the VCF file.
#'
#' @examples
#' \dontrun{
#' vcfData <- loadVCF("/path/to/file.vcf", "hg19")
#' }
#'
#' @import VariantAnnotation
#' @export
loadVcf <- function(pathToVcf, genome) {
  vcfFile <- VariantAnnotation::VcfFile(pathToVcf, index = paste(pathToVcf, "tbi", sep="."))
  vcf <- VariantAnnotation::readVcf(vcfFile, genome = "hg19")
  return(vcf)
}
