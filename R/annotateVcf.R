#' Title
#'
#' @param vcf
#' @param txdb
#'
#' @return
#' @export
#'
#' @examples
annotateVcf <- function(vcf, txdb) {
  seqlevels(vcf) <- paste0("chr", seqlevels(vcf)) # TO-DO: check format first
  annotatedVariants <- predictCoding(vcf, txdb, seqSource = Hsapiens)
  return(annotatedVariants)
}
