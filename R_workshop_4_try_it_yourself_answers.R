# TRY IT YOURSELF ANSWERS

# Part 1

# Q1 Read the VCF file Volucella_bombylans.vcf.gz provided for you on moodle into
# your R environment
vcf2 <- read.vcfR("Volucella_bombylans.vcf.gz")

# Q2 print the dimensions of the VCF to your R console
dim(vcf2)

# Q3 Filter the vcf so that it contains only the three individuals: VB20001, VB20005
# and VB21020 (remember you will also need the format column)
colnames(vcf2@gt) # check the individuals that are in the vcf
to_keep <- c("FORMAT", "VB20001", "VB20005", "VB21020") # choose columns to keep
vcf2[,to_keep]

# Q4 Query the VCF to see how many sites are biallelic, output the result as a table
table(is.biallelic(vcf2))

# Q5 Query the VCF to see how many sites are indels, output the result as a table
table(is.indel(vcf2))

# Q6 Show how you would filter the VCF to contain only sites that are NOT indels
vcf2 <- vcf[!is.indel(vcf),]

# Q7 Convert your vcfR object to chromR format and plot some general stats on the
# chromR object
chrom2 <- create.chromR(vcf2, name = "chr5")
plot(chrom2)

# BONUS Make a mask to filter your chromR object – use the plots from question 7 to
# guide you about where to set your thresholds, write out your filtered vcf to a new
# file with a different name
chrom2 <- masker(chrom2, min_QUAL = 50, min_DP = 200, max_DP = 800, min_MQ = 52,  max_MQ = 60)
table(chrom@var.info$mask) # look again at the mask
write.vcf(chrom2, mask = T, file = "filtered_Volucella_bombylans.vcf.gz")


# part 2


# example script to be run with the Rscript command from your terminal:

# load our libraries
library(ggplot2)
library(adegenet)
library(vcfR)

# read in the stickleback data
vcf <- read.vcfR("stickleback_snps.vcf.gz")

# extract the genotype matrix
mat <- extract.gt(vcf)

# transpose the matrix
mat <- t(mat)

# convert the matrix to a genind object
gen <- df2genind(mat, sep = "/", ind.names = row.names(mat))

# calculate allele frequencies
allele_freqs <- tab(gen, freq = T, NA.method = "mean")

# perform the PCA (without user input)
pca <- dudi.pca(df = allele_freqs, center = T, scale = F, scannf = FALSE, nf = 3)

# extract PC scores for plotting
pca_data <- as.data.frame(pca$li[,1:3])
# extract the individual names as a column
pca_data$Individual <- row.names(pca_data)
# update the column names to make them more readable
colnames(pca_data) <- c("PC1", "PC2", "PC3","Individual")

# plot the PCA
pca_plot <-
ggplot(pca_data, aes(PC1, PC2)) +
  geom_point()

# save the plot
jpeg("stickleback_pca_plot.jpg", width = 13, height = 10, units = "cm", res = 600)
pca_plot
dev.off()

