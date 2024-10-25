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
class(vcf) # look at the class
dim(vcf) # look at the dimensions
head(vcf) # look at the top of the file

# we can access the different data slots within our vcfR object 
# using the @ symbol e.g.
vcf@meta 
head(vcf@fix)
head(vcf@gt)

# selecting certain individuals from the vcf file

# look at our vcf file, there are 156 individuals
vcf

# select the first 4 (but we only get 3)
vcf[ ,1:4]

# this is because the first column is the format information and not an individual
head(vcf@gt[,1:4])

# so to get the first 4 individuals we would actually have to do
vcf[ ,1:5]

# what if we wanted to filter SNPs?
# we can access and select rows just the same as with a data frame e.g.
vcf[1:4,]

# subsetting certain individuals by name:

# look at the individual names
colnames(vcf@gt)

# make a vector of the individuals we want to keep
to_keep <- c("FORMAT", "Cist_16001", "Cist_16002", "Cist_16003", "Cist_16004")

# filter based on this vector we have made
vcf[, to_keep]



# Querying the genotype matrix

is.biallelic(vcf) # we can ask whether each variant is biallelic
table(is.biallelic(vcf)) # and plot a table of the output

is.indel(vcf) # or we ask whether each variant is an indel (insertion or deletion)
table(is.indel(vcf)) # and plot a table of the output

# we can also filter based on these queries e.g.
# get only the biallelic sites
vcf[is.biallelic(vcf),]

# get only the non biallelic sites
vcf[!is.biallelic(vcf),]

# keep only the biallelic sites in a new vcf
vcf2 <- vcf[is.biallelic(vcf),]

# write our filtered file out of R
write.vcf(vcf2, "filtered_stickleback_snps_1.vcf.gz")





# chromR objects

# create a chromR object from a vcfR object
chrom <- create.chromR(vcf, name = "chrom")

plot(chrom) # plot some basic information about our data

# we can create a mask to filter our data
table(chrom@var.info$mask) # the mask slot is currently empty

# here we make a mask
chrom <- masker(chrom, min_QUAL = 10, min_DP = 300, max_DP = 8000, min_MQ = 30, max_MQ = 60)

# now the mask slot contains information about filtering
table(chrom@var.info$mask)


# We can also summarise information in windows
chrom@win.info # at the moment the window info is empty
chrom <- proc.chromR(chrom, win.size = 500) # this creates the summary in windows
chrom@win.info # now we have populated the window info

# and we can plot our windowed summary
chromoqc(chrom, dp.alpha = 50)

# if we wanted to write out our chromR object with the mask:
write.vcf(chrom, mask = T, "filtered_stickleback_snps_2.vcf.gz")

# or without the mask:
write.vcf(chrom, mask = F, "filtered_stickleback_snps_2.vcf.gz")




# section 2 PCA #

# read in the hoverfly data
vcf2 <- read.vcfR("Volucella_bombylans.vcf.gz")

# extract the genotype matrix
mat <- extract.gt(vcf2)
mat # have a look at our matrix

# at the moment the matrix has individuals as columns and variants as rows
# so we need to transpose it
mat <- t(mat) # transpose the matrix
mat # check we have transposed it successfully and individuals are now rows

# now we need to convert the matrix to a genind object
gen <- df2genind(mat, sep = "/", ind.names = row.names(mat))
gen # have a look at the object we have created

# calculate allele frequencies
allele_freqs <- tab(gen, freq = T, NA.method = "mean")

# perform the PCA
pca <- dudi.pca(allele_freqs, center = T, scale = F) # this will allow you to choose the number of axes you want to retain

# this code will perform the same PCA but retain the first 3 axes non-interactively
pca <- dudi.pca(df = allele_freqs, center = T, scale = F, scannf = FALSE, nf = 3)

# look at a summary of our PCA
summary(pca)

# access the PC scores
pca$li

# extract PC scores for plotting
pca_data <- as.data.frame(pca$li[,1:3])
# the individual names are stored in the row names so extract them as a column
pca_data$Individual <- row.names(pca_data)
# update the column names to make them more readable
colnames(pca_data) <- c("PC1", "PC2", "PC3","Individual")


# plot the PCA
ggplot(pca_data, aes(PC1, PC2)) +
  geom_point()

# read in information about the individuals
sample_info <- read.csv("phenotype_covariates.csv")

# merge the data frames together
pca_sample_data <- merge(pca_data, sample_info, by = "Individual")

# plot the PCA again with the new data so that we can use the sample data
# to colour the individuals in the plot
# try colouring with location
pca_plot <-
ggplot(pca_sample_data, aes(PC1, PC2, colour = Location)) +
  geom_point()

# or with latitude
pca_plot <-
  ggplot(pca_sample_data, aes(PC1, PC2, colour = Latitude)) +
  geom_point()

# or with sex
pca_plot <-
  ggplot(pca_sample_data, aes(PC1, PC2, colour = Sex)) +
  geom_point()

# if we want to save the plot we can use the jpeg function
jpeg("pca_plot.jpg", width = 13, height = 10, units = "cm", res = 600)
pca_plot
dev.off()




