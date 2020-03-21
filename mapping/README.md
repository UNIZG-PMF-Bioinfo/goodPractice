# Scripts used for mappings  

All of them differ in parameters for mapping and expected input files. They are always:  
INPUTS: 
```
  - varname=whattomap.fasta (varname changes in script)  
  - genome=genome.fasta  
```
OUTPUTS:  
```
  - whattomaptogenome.paf  
  - whattomaptogenome.sorted.bam  
  - whattomaptogenome.sorted.bam.bai  
  - whattomaptogenome.flagstat.txt  
```

### details :   

transcripts  
  - Transcripts are mapped to genome using minimap -x splice -K10000M 
Call: 
```
qsub -v genome=genome.fasta,transcripts=transcripts.fasta minimapTranscriptsToGenome.sh  
```

nano  
  - Nanopores are mapped using -x map-ont -y -K10000M -p 0.95 
Call: 
```
qsub -v genome=genome.fasta,nano=nanopores.fasta minimapTranscriptsToGenome.sh  
```
assembly  
  - another assembly is mapped using -x asm20 -Y -N100 -p 0.98 -K10000M  
Call: 
```
qsub -v genome=genome.fasta,assembly=assembly2.fasta minimapTranscriptsToGenome.sh  
```

paired reads 
  - Illumina reads mapped with -x sr  
  - works also for RNAseq reads but preferred is splice aware STAR or other.  
Call: 
```
qsub -v genome=genome.fasta,reads=reads.fasta minimapTranscriptsToGenome.sh  
```



