#!/bin/bash
# job name
#PBS -N mmAssembly
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
OUTn=${assembly%%.fasta}
OUTg=${genome%%.fasta}
OUT=${OUTn}to${OUTg}

$minimap -x asm20 -Y -N100 -p 0.98 -K 10000M -t12 $genome $assembly -o ${OUT}.paf
$minimap -ax asm20 -Y -N100 -p 0.98 -K 10000M -t12 $genome $assembly -o ${OUT}.sam

sambamba=/common/WORK/fhorvat/programi/sambamba/sambamba
$sambamba view -t 12 -f bam -S -o ${OUT}.bam ${OUT}.sam
$sambamba sort -m 80GB --tmpdir tmp -t 12 ${OUT}.bam
$sambamba flagstat -t 12 ${OUT}.sorted.bam > ${OUT}.flagstat.txt

rm ${OUT}.sam ${OUT}.sam 
rm -r tmp
chmod 444 ${OUT}*
