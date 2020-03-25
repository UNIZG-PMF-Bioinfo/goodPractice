#!/bin/bash
#PBS -N samtosortedbam
#PBS -m ea
#PBS -M youremail@mail.com
#PBS -q MASTER
#PBS -l select=1:ncpus=6:mem=120G
cd $PBS_O_WORKDIR

SAMBAMBA=/common/WORK/fhorvat/programi/sambamba/sambamba
$SAMBAMBA view -f bam -F "" -o ${IN}.bam -t 6 -S ${IN}.sam
$SAMBAMBA sort -m 100GB --tmpdir tmp -t 6 ${IN}.bam
$SAMBAMBA flagstat -t 10 ${IN}.sorted.bam > ${IN}.flagstat.txt
rm ${IN}.sam ${IN}.bam
rm -r tmp
chmod 755 * 
