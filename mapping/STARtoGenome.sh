#!/bin/bash
# ----------------QSUB Parameters----------------- #
#PBS -q MASTER
#PBS -N STAR
##PBS -M your@mail.com
#PBS -m n
#PBS -j oe
#PBS -l select=ncpus=12:mem=100g
cd $PBS_O_WORKDIR

# Path to STAR bins
STARPATH=/common/WORK/fhorvat/programi/STAR/STAR-2.5.3a/bin/Linux_x86_64
THREADS=12

# ----------------DECLARATIONS------------------- #
### Files required as input:
### rna1 - fq.gz first in pair 
### rna2 - fq.gz second in pair 
### genome - fasta
### OUT - prefix of alignment
# ----------------GENERATE INDEX--------------- #

mkdir ${genome}_index
${STARPATH}/STAR --runThreadN $THREADS --runMode genomeGenerate --genomeDir /${PBS_O_WORKDIR}/${genome}_index --genomeFastaFiles $genome

# ----------------RUN ALINGMENTS--------------- #
${STARPATH}/STAR --runThreadN $THREADS --genomeDir /${PBS_O_WORKDIR}/${genome}_index --readFilesIn $rna1 $rna2 --readFilesCommand zcat --outFileNamePrefix $OUT  

sambamba=/common/WORK/fhorvat/programi/sambamba/sambamba
$sambamba view -F "" -t 12 -f bam -S -o ${OUT}.bam ${OUT}.sam
$sambamba sort -m 80GB --tmpdir tmp -t 12 ${OUT}.bam
$sambamba flagstat -t 12 ${OUT}.sorted.bam > ${OUT}.flagstat.txt

rm ${OUT}.sam ${OUT}.sam 
rm -r tmp
chmod 444 ${OUT}*
