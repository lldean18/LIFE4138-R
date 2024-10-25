######################
#### R WORKSHOP 4 ####
######################

# start by clearing your working environment and plot history
rm(list = ls())
dev.off()

# install new packages
install.packages("adegenet")
install.packages("vcfR")

# load our libraries
library(ggplot2)
library(adegenet)
library(vcfR)

# reading in a vcf file
vcf <- read.vcfR("stickleback_snps.vcf.gz")

# lets get some info on the VCF file
class(vcf)
dim(vcf)
head(vcf)

vcf@meta
head(vcf@fix)
head(vcf@gt)

# look at our vcf file, there are 156 individuals
vcf

# select the first 4 (but we only get 3)
vcf[ ,1:4]

# this is because the first column is the format information and not an individual
head(vcf@gt[,1:4])

# what if we wanted to filter SNPs?
vcf[1:4,]

# look at the individual names
colnames(vcf@gt)

# make a vector of the individuals we want to keep
to_keep <- c("FORMAT", "Cist_16001", "Cist_16002", "Cist_16003", "Cist_16004")

vcf[, to_keep]

# Querying the genotype matrix

is.biallelic(vcf)
table(is.biallelic(vcf))

is.indel(vcf)
table(is.indel(vcf))

# get only the biallelic sites
vcf[is.biallelic(vcf),]

# get only the non biallelic sites
vcf[!is.biallelic(vcf),]

# keep only the biallelic sites in a new vcf
vcf2 <- vcf[is.biallelic(vcf),]

# write our filtered file out of R
write.vcf(vcf2, "filtered_stickleback_snps_1.vcf.gz")

# chromR objects

# create a chromR object
chrom <- create.chromR(vcf, name = "chrom")

plot(chrom)

table(chrom@var.info$mask)

chrom <- masker(chrom, min_QUAL = 10, min_DP = 300, max_DP = 8000, min_MQ = 30, max_MQ = 60)

table(chrom@var.info$mask)


# summarise information in windows
chrom@win.info
chrom <- proc.chromR(chrom, win.size = 500)
chrom@win.info

# plot our windowed summary
chromoqc(chrom, dp.alpha = 50)

# write out our chromR object with the mask
write.vcf(chrom, mask = T, "filtered_stickleback_snps_2.vcf.gz")



# section 2 PCA 

# read in the hoverfly data
vcf2 <- read.vcfR("Volucella_bombylans.vcf.gz")

# extract the genotype matrix
mat <- extract.gt(vcf2)

mat

# we need to transpose our matrix
mat <- t(mat)
mat

gen <- df2genind(mat, sep = "/", ind.names = row.names(mat))
gen

# calculate allele frequencies
allele_freqs <- tab(gen, freq = T, NA.method = "mean")

# perform PCA
pca <- dudi.pca(allele_freqs, center = T, scale = F)

pca <- dudi.pca(df = allele_freqs, center = T, scale = F, scannf = FALSE, nf = 3)


summary(pca)

# access the PC scores
pca$li

# extract PC scores for plotting
pca_data <- as.data.frame(pca$li[,1:3])
pca_data$Individual <- row.names(pca_data)
colnames(pca_data) <- c("PC1", "PC2", "PC3","Individual")

# plot the PCA
library(ggplot2)

ggplot(pca_data, aes(PC1, PC2)) +
  geom_point()

# read in information about the individuals
sample_info <- read.csv("phenotype_covariates.csv")

# merge the data frames together
pca_sample_data <- merge(pca_data, sample_info, by = "Individual")

pca_plot <-
ggplot(pca_sample_data, aes(PC1, PC2, colour = Location)) +
  geom_point()

# save the plot
jpeg("pca_plot.jpg", width = 13, height = 10, units = "cm", res = 600)
pca_plot
dev.off()




