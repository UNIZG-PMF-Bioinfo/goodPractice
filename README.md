# scripts
general scripts for best practice  

### samToSortedbam.sh  
script takes one argument, IN - the prefix of the .sam file. Processes ${IN}.sam to ${IN}.sorted.bam and writes statistics to ${IN}.flagstat.txt. Removes ${IN}.sam. Does NOT filter any alignments from original .sam file!  


