vcf_test <- vcfR::read.vcfR("~/Downloads/homo_sapiens-chr21.vcf.gz")
data("vcfR_test")
vcf_test

mutation_data <- as.data.frame(getFIX(vcf_test))

head(vcfR_test)

rm(mutation_data)
rm(vcf_test)

vcffile <- VcfFile("~/Downloads/homo_sapiens-chr21.vcf.gz", index = paste("~/Downloads/homo_sapiens-chr21.vcf.gz", "csi", sep="."))
vcf_test <- VariantAnnotation::readVcf(vcffile)

vcf_filename <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
vcf <- readVcf(vcf_filename, "hg19")
vcf

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
annotated_variants <- locateVariants(vcf, txdb, CodingVariants())
