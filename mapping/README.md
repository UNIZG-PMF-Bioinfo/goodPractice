## scripts used for mappings  

### minimapTranscriptsToGenome.sh   

Maps transcripts to genome.  

INPUTS: 
```
  - transcripts=transcripts.fasta  
  - genome=genome.fasta  
```
OUTPUTS:  
```
  - transcripttogenome.paf  
  - transcripttogenome.sorted.bam  
  - transcripttogenome.sorted.bam.bai  
  - transcripttogenome.flagstat.txt  
```

call example: 
```
qsub -v genome=genomename.fasta,transcripts=transcripts.fasta minimapTranscriptsToGenome.sh
```
