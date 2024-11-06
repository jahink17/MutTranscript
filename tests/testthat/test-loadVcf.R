test_that("loadVcf successfully loads a VCF file", {
  test_vcf_path <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
  vcf <- loadVcf(test_vcf_path)
  expect_s4_class(vcf, "VCF")
})

test_that("loadVcf throws an error for a nonexistent VCF file", {
  expect_error(loadVcf("nonexistent.vcf"),
               info = "Function should throw an error if VCF file does not exist.")
})
