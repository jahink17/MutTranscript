#' Load a VCF file into R
#'
#' A function that loads a VCF (Variant Call Format) file, specified by the file path, into R.
#' It returns a VCF object, which can be further used for variant analysis. It also adds the 'chr' prefix to
#' chromosome names if it hasn't been added already, to make downstream steps compliant with preconditions.
#'
#' @param pathToVcf A string representing the file path to the VCF file. The VCF file must have mutations aligned using the hg19 reference genome; other genomes are not supported at the moment.
#'
#' @return A `VCF` object containing the variants from the VCF file. Seqnames are ensured to have the 'chr' prefix.
#'
#' @examples
#' \dontrun{
#' vcfData <- loadVCF("/path/to/file.vcf", "hg19")
#' }
#'
#' @import VariantAnnotation
#' @import GenomicFeatures
#' @export
loadVcf <- function(pathToVcf) {
  vcfFile <- VariantAnnotation::VcfFile(pathToVcf, index = paste(pathToVcf, "tbi", sep="."))
  vcf <- VariantAnnotation::readVcf(vcfFile, genome = "hg19")
  if (all(!grepl("^chr", GenomeInfoDb::seqlevels(vcf)))) {
    GenomeInfoDb::seqlevels(vcf) <- paste0("chr", GenomeInfoDb::seqlevels(vcf))
  }
  return(vcf)
}
