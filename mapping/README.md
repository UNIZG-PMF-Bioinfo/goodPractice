# Scripts used for mappings  
All of them differ in parameters for mapping and expected input files. They are always:  

### INPUTS: 
```
  - varname=whattomap.fasta (varname changes in script call depending on what you map! STAR expects .fq.gz)  
  - genome=genome.fasta  
```
### OUTPUTS:  
```
  - whattomaptogenome.paf  
  - whattomaptogenome.sorted.bam  
  - whattomaptogenome.sorted.bam.bai  
  - whattomaptogenome.flagstat.txt  
  - whattomaptogenome.coverage.txt
```

### details :   

transcripts  
  - Transcripts are mapped to genome using minimap -x splice -K10000M  

```
qsub -v genome=genome.fasta,transcripts=transcripts.fasta minimapTranscriptsToGenome.sh  
```

nano  
  - Nanopores are mapped using -x map-ont -y -K10000M -p 0.95  

```
qsub -v genome=genome.fasta,nano=nanopores.fasta minimapNanoToGenome.sh  
```
assembly  
  - another assembly is mapped using -x asm20 -Y -N100 -p 0.98 -K10000M  

```
qsub -v genome=genome.fasta,assembly=assembly2.fasta minimapAssemblyToGenome.sh  
```

paired reads 
  - Illumina reads mapped with -x sr  
  - works also for RNAseq reads but preferred is splice aware STAR or other.  
  - make sure reads file ends with somename*1.fasta* and somename2.fasta  

```
qsub -v genome=genome.fasta,reads1=reads1.fasta,reads2=reads2.fasta minimapShortReadsToGenome.sh  
```

RNAseq reads:  
  - rna .fq.gz paired reads mapped to genome with splice site aware STAR.
  - is not modified to map to repeats!  
```
qsub -v genome=genome.fasta,rna1=rna1.fq.gz,rna2=rna2.fq.gz,OUT=rnaSTARtoGenome STARtoGenome.sh
```
  

