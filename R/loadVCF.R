# To-do: Need to check if this works on test file
# To-do: Need to add functionality to create index file if not present
# To-do: Need to extend to hg38
#' Title
#'
#' @param pathToVcf
#' @param genome
#'
#' @return
#' @export
#'
#' @examples
loadVcf <- function(pathToVcf, genome) {
  vcffile <- VariantAnnotation::VcfFile(pathToVcf, index = paste(pathToVcf, "tbi", sep="."))
  vcf <- VariantAnnotation::readVcf(vcffile, genome = "hg19")
  return(vcf)
}
