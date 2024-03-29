library(tximport)
library(readr)
library(AnnotationDbi)
library(GenomicFeatures)

setwd("/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/")

##	read samples from ID file
samples <- read.table("ID.txt", header=FALSE)
colnames(samples) <- "samples"

##	get files from path
files <- file.path("salmon_output", samples$sample, "quant.sf")
samplename <- strsplit(samples$sample, split="_")
samplename <- matrix(unlist(samplename), ncol=3, byrow=T)
names(files) <- paste0(samplename[,1])

##	make txdb file from GTF then create tx2gene file
txdb <- makeTxDbFromGFF("/net/beegfs/scratch/imuller/genomereference/gencode.v42.chr_patch_hapl_scaff.annotation.gtf", format="gtf", dataSource = "Hg38 GTF Gencode", organism = "Homo sapiens")
k <- keys(txdb, keytype = "TXNAME")
tx2gene <- select(txdb, k, "GENEID", "TXNAME")

#head(tx2gene)

##	import using tximport
txi.salmon <- tximport(files, type = "salmon", tx2gene = tx2gene)

###salmon quant gives count estimates and not read numbers so need to round the counts to use in EdgeR
txi.salmon$counts<- round(txi.salmon$counts)

#head(txi.salmon$counts)

##write csv file
##write.csv(txi.salmon, "counts_UAE120.csv")

saveRDS(txi.salmon, "counts.RDS")
