test_that("annotateCodingVcf returns non-null output", {
  annotated_vcf <- annotateCodingVcf(mutationsVcf)
  expect_true(!is.null(annotated_vcf), info = "Output should not be NULL.")
})

test_that("annotateCodingVcf returns a GRanges object", {
  annotated_vcf <- annotateCodingVcf(mutationsVcf)
  expect_s4_class(annotated_vcf, "GRanges")
})
