#!/home/josephus/R_sources/R-3.5.1/bin/Rscript

# rm(list=ls()) 

require(rbamtools)
require(Rsamtools)
require(GenomicAlignments)
require(rtracklayer)
require(Rsubread)

# /media/daten/arnold/josephus/script/rsubread-oct2018-mouse.r \
# bra-dld-lit-data \
# "_1.fastq" \
# "${in_dir}" \
# "${align_dir}" \
# "${count_dir}" \
# 16
 

args.vec <- commandArgs(trailingOnly=TRUE)
name <- args.vec[1] # core name
fastq_ending <- args.vec[2]
indir <- args.vec[3]
align.outdir <- args.vec[4]
count.outdir <- args.vec[5]
nthread <- args.vec[6]

############################################################
# SETTING
############################################################

genomepath <-  "/media/daten/arnold/josephus/genome/Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/genome.fa"
gtfpath <-  "/media/daten/arnold/josephus/genome/Mus_musculus/UCSC/mm10/Annotation/Archives/archive-2015-07-17-14-33-26/Genes/genes.gtf"
indexdir <- "/media/daten/arnold/josephus/genome/subread-index-mm10"

############################################################
# ensure existence of output directories
############################################################

dir.create(indexdir, recursive = TRUE, showWarnings = FALSE)
dir.create(align.outdir, recursive = TRUE, showWarnings = FALSE)
dir.create(count.outdir, recursive = TRUE, showWarnings = FALSE)

##########################################################
# build subread index (once done, not necessary)
##########################################################
if (!file.exists(file.path(indexdir, "reference_index.reads")))	{
  buildindex(basename=file.path(indexdir, "reference_index"),
             reference=genomepath)
}

##########################################################
# detect fastq files for paired-end read
##########################################################
reads_R1 <- list.files(path = indir, pattern = paste0("^", name, fastq_ending))
reads_R2 <- list.files(path = indir, pattern = paste0("^", name, gsub("1", "2", fastq_ending)))
print(reads_R1)
print(reads_R2)

##########################################################
# mapping/alignment using index
##########################################################
align(index=file.path(indexdir, "reference_index"), 
      readfile1 = file.path(indir, reads_R1),
      readfile2 = file.path(indir, reads_R2),
      type = "rna", # or 0 for RNA, 1 for DNA or "dna"
      output_format = "BAM",
      output_file = paste(align.outdir, "/", gsub(fastq_ending, "", reads_R1), "-align.bam", sep=''),
      phredOffset = 33,
      nthreads = nthread)

##########################################################
# sort bam
##########################################################
require(rbamtools)
bamfiles <- paste0(align.outdir, "/", name, "-align.bam", collapse = '')
bamnames <- paste0(name, "-align.bam", collapse = '')

for (i in 1:length(bamfiles)) {
  bampath <- bamfiles[i]
  bamname <- bamnames[i]
  bam.obj <- bamReader(bampath,idx=FALSE,verbose=0)
  bam_prefix <- gsub(".bam", "-srt", bamname)
  bamSort(bam.obj, prefix=bam_prefix, byName = F, maxmem = 1e+9) # byName = F if position
}



##########################################################
# bam 2 bigwig
##########################################################
require(GenomicAlignments)
require(rtracklayer)

bamfiles <- dir(align.outdir, pattern = paste0(name, "-align-srt.bam"), full.names = T)
bamnames <- dir(align.outdir, pattern = paste0(name, "-align-srt.bam"))

for (i in 1:length(bamfiles)) {
  bampath <- bamfiles[i]
  bamname <- bamnames[i]
  alignment <- readGAlignments(bampath)
  reads_coverage <- coverage(alignment)
  bigwigpath <- gsub(".bam", "-bigWig.bw", bampath)
  export.bw(reads_coverage, con = bigwigpath)
}

# ##########################################################
# # counting ensembl_id
# ##########################################################
# setwd(count.outdir)
# bampath <- paste0(align.outdir, "/", name, "-align-srt.bam", collapse = '')
# fc <- featureCounts(files = bampath,
#                     nthreads = nthread, # number of cpu cores to use
#                     isPairedEnd =TRUE,
#                     annot.ext = gtfpath,
#                     isGTFAnnotationFile = TRUE,
#                     GTF.featureType = "exon",
#                     GTF.attrType = "gene_id",
#                     juncCounts = T)
# 
# count.table <- fc$counts
# 
# # sort by name
# count.table <- count.table[order(rownames(count.table)), ]
# 
# # print ENSMUSG
# write.table(count.table, paste0(file.path(count.outdir, name), "-ens-fcount.tab", collapse = ''), sep = "\t", quote = FALSE, col.names = FALSE)


##########################################################
# counting symbols
##########################################################

fc <- featureCounts(files = bampath,
                    nthreads = nthread, # number of cpu cores to use
                    isPairedEnd =TRUE,
                    annot.ext = gtfpath,
                    isGTFAnnotationFile = TRUE,
                    GTF.featureType = "exon",
                    GTF.attrType = "gene_name",
                    juncCounts = T)

count.table <- fc$counts[order(rownames(fc$counts)), ]

# print symbol
write.table(count.table, paste0(file.path(count.outdir, name), "-sym-fcount.tab", collapse = ''), sep = "\t", quote = FALSE, col.names = FALSE)


##########################################################
# counting exon_id
##########################################################

# fc <- featureCounts(files = bampath,
#                     nthreads = nthread, # number of cpu cores to use
#                     isPairedEnd =TRUE,
#                     annot.ext = gtfpath,
#                     isGTFAnnotationFile = TRUE,
#                     GTF.featureType = "exon",
#                     GTF.attrType = "exon_id",
#                     juncCounts = T)

# count.table <- fc$counts[order(rownames(fc$counts)), ]

# # print symbol
# write.table(count.table, paste0(file.path(count.outdir, name), "-exn-fcount.tab", collapse = ''), sep = "\t", quote = FALSE, col.names = FALSE)


##########################################################
# counting transcript_id
##########################################################

# fc <- featureCounts(files = bampath,
#                     nthreads = nthread, # number of cpu cores to use
#                     isPairedEnd =TRUE,
#                     annot.ext = gtfpath,
#                     isGTFAnnotationFile = TRUE,
#                     GTF.featureType = "exon",
#                     GTF.attrType = "transcript_id",
#                     juncCounts = T)

# count.table <- fc$counts[order(rownames(fc$counts)), ]

# print symbol
# write.table(count.table, paste0(file.path(count.outdir, name), "-trn-fcount.tab", collapse = ''), sep = "\t", quote = FALSE, col.names = FALSE)



