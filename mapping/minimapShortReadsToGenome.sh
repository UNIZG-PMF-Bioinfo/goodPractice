#!/bin/bash
# job name
#PBS -N mmSR
## when and who to mail - change if you want mail and remove one starting # 
##PBS -m bea
## PBS -M your@mail.com
# queue:
#PBS -q MASTER
#PBS -l select=1:ncpus=12:mem=80G

cd $PBS_O_WORKDIR

##------------------------------------------------------------------#
## script expects input names for genome and reads1.fq and reads2.fq files!
## be careful that reads1 file name ends in sufix 1.fq !
## call it with qsub -v genome=genomename.fasta,reads1=reads1.fq,reads2=reads2.fq minimapShortReadsToGenome.sh
##------------------------------------------------------------------#

minimap=/common/WORK/mfabijanic/programs/miniconda3/bin/minimap2
OUTn=${reads1%%1.fq}
OUTg=${genome%%.fasta}
OUT=${OUTn}to${OUTg}

$minimap -x sr -Y -K 10000M -t 12 $genome $reads1 $reads2 -o ${OUT}.paf
$minimap -ax sr -Y -K 10000M -t 12 $genome $reads1 $reads2 -o ${OUT}.sam

sambamba=/common/WORK/fhorvat/programi/sambamba/sambamba
$sambamba view -F "" -t 12 -f bam -S -o ${OUT}.bam ${OUT}.sam
$sambamba sort -m 80GB --tmpdir tmp -t 12 ${OUT}.bam
$sambamba flagstat -t 12 ${OUT}.sorted.bam > ${OUT}.flagstat.txt

rm ${OUT}.sam ${OUT}.sam 
rm -r tmp
sambamba depth region -t 12 -c0 -o ${OUT}.coverage.txt -L chrInfo.txt -T 0 -T 10 -T 50 -T 100 -T 200 ${OUT}.sorted.bam
chmod 444 ${OUT}*
