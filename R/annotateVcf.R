annotateVcf <- function(vcfFile, txdb) {
  annotatedVariants <- locateVariants(vcf, txdb, CodingVariants())
  return(annotated_variants)
}
