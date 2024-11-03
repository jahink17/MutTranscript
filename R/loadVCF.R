# To-do: Need to check if this works on test file
# To-do: Need to add functionality to create index file if not present
# To-do: Need to extend to hg38
loadVcf <- function(pathToVcf, genome) {
  vcffile <- VcfFile(pathToVcf, index = paste(pathToVcf, "tbi", sep="."))
  vcf <- readVcf(pathToVcf, genome = "hg19")
}
