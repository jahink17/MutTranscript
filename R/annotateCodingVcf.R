#' Annotate a VCF object
#'
#' Annotates a VCF object using the `predictCoding()` function from
#' VariantAnnotation using data from the `TxDb.Hsapiens.UCSC.hg19.knownGene`
#' package. Specifically, it adds transcript-level information about coding
#' sequence mutations, such as transcript ID, exon number, distance of the
#' mutation site from the transcription start site (excluding introns and UTRs),
#' etc. Mutations in non-coding regions are excluded.
#'
#' @param vcf A `VCF` object belonging to the `VCF` class from the
#'   `VariantAnnotation` package. Can be loaded by using the `readVcf()`
#'   function on a suitable VCF file. The VCF file must follow the VCF format
#'   specifications. See `?VariantAnnotation::readVcf()` for more details.
#'
#' @return a `GRanges` object with a row for each variant-transcript match. For
#'   more information about the information stored in the columns, see the `See
#'   Also` section.
#'
#' @seealso To obtain more information about the metadata columns in the
#'   returned `GRanges` object, see [VariantAnnotation::predictCoding()] which
#'   is used by this function to obtain the annotated `GRanges` object.
#' @export
#' @import TxDb.Hsapiens.UCSC.hg19.knownGene
#' @import VariantAnnotation
#' @import BSgenome.Hsapiens.UCSC.hg19
#' @import GenomeInfoDb
#'
#' @examples
#' annotatedVcf <- annotateCodingVcf(mutationsVcf)
#' annotatedVcf
#' @md
annotateCodingVcf <- function(vcf) {
  txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene::TxDb.Hsapiens.UCSC.hg19.knownGene
  GenomeInfoDb::seqlevels(vcf) <- paste0("chr", seqlevels(vcf)) # TO-DO: check format first
  annotatedVariants <- VariantAnnotation::predictCoding(vcf, txdb, seqSource = Hsapiens)
  return(annotatedVariants)
}
