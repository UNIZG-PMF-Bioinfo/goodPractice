#!/bin/bash
# job name
#PBS -N mm
## when and who to mail - change if you want mail and remove one starting # 
##PBS -m bea
## PBS -M your@mail.com
# queue:
#PBS -q MASTER
#PBS -l select=1:ncpus=12:mem=80G

cd $PBS_O_WORKDIR

##------------------------------------------------------------------#
## script expects input names for genome and nanopores.fasta files!
## call it with qsub -v genome=genomename.fasta,nano=nanopores.fasta minimapTranscriptsToGenome.sh
##------------------------------------------------------------------#

minimap=/common/WORK/mfabijanic/programs/miniconda3/bin/minimap2
OUTn=${nano%%.fasta}
OUTg=${genome%%.fasta}
OUT=${OUTn}to${OUTg}

$minimap -x map-ont -Y -K10000M -p0.95 -t 12 $genome $nano -o ${OUT}.paf
$minimap -ax map-ont -Y -K10000M -p0.95 -t 12 $genome $nano -o ${OUT}.sam

sambamba=/common/WORK/fhorvat/programi/sambamba/sambamba
$sambamba view -F "" -t 12 -f bam -S -o ${OUT}.bam ${OUT}.sam
$sambamba sort -m 80GB --tmpdir tmp -t 12 ${OUT}.bam
$sambamba flagstat -t 12 ${OUT}.sorted.bam > ${OUT}.flagstat.txt

rm ${OUT}.sam ${OUT}.bam 
rm -r tmp
sambamba depth region -t 12 -c0 -o ${OUT}.coverage.txt -L chrInfo.txt -T 0 -T 1 -T 5 -T 10 -T 20 ${OUT}.sorted.bam
chmod 444 ${OUT}*
