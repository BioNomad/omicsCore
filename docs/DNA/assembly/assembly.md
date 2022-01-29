# Assembly

So say you don't have a perfectly sequenced/ well characterized genome? Well you wouldn't have anything to compare your reads to. That's ok though you can build a new genome, *de novo*. In this workshop we will be using Staphylococcus aureus bacterium whole genome data. To begin we will need to take a closer look at our read data.

## Fastq File Format

Read data is stored into files called fastq files. These files are laid out like so:

![](images/fastq.PNG)

So here we can see we have a sequence identifier, the actual sequence, an optional separator and the quality scores of each base. The quality scores are encoded differently depending on the technology:

![](images/quality.PNG)

These quality scores are associated with the probability that the sequencer called the wrong base. 

![](images/prob.PNG)

So before we go and start assembling our genome, we should confirm that our read data quality is alright.

## Quality Control

To get an idea of how well our read data quality we can use a package called FastQC. To do so we will write a bash script:

    #!/bin/bash
    
    # Download read data and run FastQC #
    
    # make a directory for raw data
    mkdir raw_data
    cd raw_data
    
    # download it
    wget https://zenodo.org/record/582600/files/mutant_R1.fastq
    wget https://zenodo.org/record/582600/files/mutant_R2.fastq
    
    # make an output directory
    cd ../
    mkdir fastqc
    
    # run fastqc
    fastqc raw_data/* -o fastqc
    
So in the script we do a little house keeping and create directories for our raw data and quality control results. We then download our read data and run FastQC. FastQC will output an html file with summary plots and flat text files with this data per fastq file. Let's examine the plots!

### Per base sequence quality

![](images/pbsq.PNG)
    
### Per sequence quality scores

![](images/psqs.PNG)

### Per base sequence content

![](images/pbsc.PNG)

### Per sequence GC content

![](images/psgc.PNG)

### Per base N content

![](images/pbnc.PNG)

### Sequence Length Distribution

![](images/sld.PNG)

### Sequence Duplication Levels

![](images/sdl.PNG)

### Overrepresented sequences

![](images/os.PNG)

### Adapter Content

![](images/ac.PNG)
  

## Assemble Reads

## Assembly Statistics
