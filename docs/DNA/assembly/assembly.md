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

Here we see the distribution of quality scores per position in the read. The plot is separated into three regions: green, orange, red. If the scores mainly fall into the green bin, your quality scores are all good. If they dip into the orange/red, you'll want to consider removing those before going forward.
    
### Per sequence quality scores

![](images/psqs.PNG)

Here we can see the distribution of the average quality score per read. If we see a spike on the lower end of the quality score range, we know there are a subset of reads with very poor quality.

### Per base sequence content

![](images/pbsc.PNG)

This plot shows us the percentage of A,G,C, and T at different positions in our reads. We *expect* that these levels stay consistent across the read in a random library. However, if these levels are not flat across the plot, it could indicate an overrepresented sequence in our data. 

### Per sequence GC content

![](images/psgc.PNG)

Here the average GC content per sequence is displayed and in a normal random library you would like this to approximate a bell curve. If your actual distribution is unusually shaped and doesn't match the theoretical distribution, you may have a contaminated library. 

> NOTE: contaminated doesn't necessarily mean your library wasn't prepared under clean conditions. In eukaryotic organisms, this may point to a viral infection - wherein a virus has integrated their genome to the host.

### Per base N content

![](images/pbnc.PNG)

When the sequencer cannot determine a base in a sequence it will insert an "N" in the sequence. The plot above maps the N content per position in the read. It is also advised that these be removed as well when they appear in excess. 

### Sequence Length Distribution

![](images/sld.PNG)

When we fragment our DNA we often times expect some uniform fragment. We can use the sequence length distribution plot to confirm most of our sequences are of that length.

### Sequence Duplication Levels

![](images/sdl.PNG)

In the process of amplifying our DNA it is possible to over represent a particular sequence. We can check the sequence duplication levels plot to confirm that most of our sequences are only seen once.

### Overrepresented sequences

If this plot is populated (here it was not) it means you have a sequence that is more than 0.1% of the total number of sequences. FastQC will go through and match these to common contaminants to give you a clue as to what the contaminant might be. If FastQC cannot match the sequence, try using [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&BLAST_SPEC=GeoBlast&PAGE_TYPE=BlastSearch) to identify the sequence. 

> NOTE: In RNA-seq it is expected that you might have overrepresented sequences depending on how much RNA is being made. DNA is expected to stay consistent and that is why we remove these overrepresented sequences here. 


### Adapter Content

![](images/ac.PNG)
  
In the process of getting read data, we needed to add adapters to our DNA fragments so that they would stick to our flow cell. The plot above shows the adapter content at different positions in a read. If we see there are adapters present, we should remove them before going forward.

### Read Trimming

While our data looks good, given the FastQC plots above, we will be thorough and run our reads through a trimming program called TrimGalore. 

    #!/bin/bash
    
    # Trim our read data #
    
    # create a directory for our trimmed data
    mkdir trim
    
    #run trim galore at default settings
    trim_galore --paired -o trim raw_data/*

We make sure to specify here that our data is paired so that it is trimmed correctly. By default, TrimGalore will autodetect partial/full adapters and remove them. Additionally, it will remove low quality bases and per our specifcation will output the trimmed files into the trim folder. 
    

## Assemble Reads

Now that we have cleaned read data we can start to do some assembly. But what does this mean? Here is a graphic to make better sense of it:

![](images/read2genome.PNG)

Here we see that to construct a genome we need to take our read data and *assemble* it into contigs which serve as a scaffold for our new genome! To assemble our reads into contigs we can use a program called Velvet. Velvet assembles our reads by using a de Bruijn graph a type of graph that displays overlaps between sequences. Determining these overlaps will help determine the order in which these sequences occur in our genome. 

![](images/debrujin.PNG)

But Velvet will need us to specify how large our kmers are going to be. Smaller kmers are great for determining the best connectivity and thereby the best sequence order and larger kmers will result in better specificity since you aren't breaking it down as much. Here we will try different kmer lengths ranging from 21 to 31.

    #!/bin/bash

    # Run velvet for different kmer lengths #
    
    #make a directory to house all the velvet output
    mkdir velvet

    #loop through different kmer lengths
    for i in 21 22 23 24 25 26 27 28 29 30 31
    do
            #run velvet at different kmer lengths
            velveth ./velvet/velvet_$i $i -fmtAuto -create_binary -shortPaired -separate ./trim/mutant_R1_val_1.fq ./trim/mutant_R2_val_2.fq
            #assemble into contigs
            velvetg ./velvet/velvet_$i
    done
    
Here we create an output folder called velvet and loop through different kmer lengths and run velvet using those different lengths. For each length, velvet will output an output folder with our contig files, a log, a stats file and other files we won't discuss here. For more information please see the [velvet documentation](https://www.ebi.ac.uk/~zerbino/velvet/Manual.pdf). Let's check out one of the contig files to understand it's structure (note in each output folder the contig file will be called "contig.fa"):

    >NODE_11_length_79_cov_21.594936
    TTGAACATTGGTTTTATGCAAGATCAGTAGAGATAACTGTAAAATGTTCTTAATATTGTC
    AAAATGTAATGCTTGAAAGCGCTTTTAAAAAATATTATTATATACAT
    >NODE_15_length_550_cov_29.652727
    TTTTTTATTTTGAGTGGTTTTGTCCGTTACACTAGAAAACCGAAAGACAATAAAAATTTT
    ATTCTTGCTGAGTCTGGCTTTCGGTAAGCTAGACAAAACGGACAAAATAAAAATTGGCAA
    GGGTTTAAAGGTGGAGATTTTTTGAGTGATCTTCTCAAAAAATACTACCTGTCCCTTGCT
    GATTTTTAAACGAGCACGAGAGCAAAACCCCCCTTTGCTGAGGTGGCAGAGGGCAGGTTT
    TTTTGTTTCTTTTTTCTCGTAAAAAAAAGAAAGGTCTTAAAGGTTTTATGGTTTTGGTCG
    GCACTGCCGACAGCCTCGCAGAGCACACACTTTATGAATATAAAGTATAGTGTGTTATAC
    TTTACTTGGAAGTGGTTGCCGGAAAGAGCGAAAATGCCTCACATTTGTGCCACCTAAAAA
    GGAGCGATTTACATATGAGTTATGCAGTTTGTAGAATGCAAAAAGTGAAATCAGCTGGAC
    TAAAAGGCATGCAATTTCATAATCAAAGAGAGCGAAAAAGTAGAACGAATGATGATATTG
    ACCATGAGCGAACACGTGAAAATTATGATTTGAAAAAT

So here we see each sequences is headed by a header with the node number, the sequence length, and the coverage. The node number is the node number in the de Brujin graph, the length of the sequence is a measure of how many kmers overlapped by at least one base pair and the coverage is a measure of how many kmers overlap at each position. So for the first header ```NODE_11_length_79_cov_21.594936```:

* The sequence is for node 11 in the graph
* The length of the sequence is 79 base pairs 
* The kmer coverage is ~21.59
    

## Assembly Statistics

So we generated 10 different contig files using different kmer lengths. How do we know which contig file is the superior assembly? Well to do so let's make use the following R script:

    # Assess contig files based on N50, max contig length, and total contig length #
    library(ggplot2)

    #set empty vectors
    kmer <- numeric()
    nodes <- numeric()
    n50 <- numeric()
    max <- numeric()
    total <- numeric()

    #loop through our different contig lengths 
    for(i in 21:31){
      log=read.delim(paste("./tufts/omicsCore/assembly/velvet/velvet_",as.character(i),"/Log",sep = ""))
      nodes.i <- as.numeric(strsplit(strsplit(log[18,],"graph has ")[[1]][2]," ")[[1]][1])
      n50.i <- as.numeric(strsplit(strsplit(log[18,],"n50 of ")[[1]][2],",")[[1]][1])
      max.i <- as.numeric(strsplit(strsplit(log[18,],"max ")[[1]][2],",")[[1]][1])
      total.i <- as.numeric(strsplit(strsplit(log[18,],"total ")[[1]][2],",")[[1]][1])
      kmer <- c(kmer,i)
      nodes <- c(nodes,nodes.i)
      n50 <- c(n50,n50.i)
      max <- c(max,max.i)
      total <- c(total,total.i)
    }

    #let's create some plots to help us make sense of our contigs
    df <- data.frame(kmer,
                     nodes,
                     n50,
                     max,
                     total)

    ggplot(data=df, aes(x=kmer, y=nodes)) +
      geom_bar(stat="identity",fill="midnightblue",alpha=.7)+
      theme_minimal()

    ggplot(data=df, aes(x=kmer, y=n50)) +
      geom_bar(stat="identity",fill="deeppink4",alpha=.7)+
      theme_minimal()

    ggplot(data=df, aes(x=kmer, y=max)) +
      geom_bar(stat="identity",fill="lightseagreen",alpha=.7)+
      theme_minimal()

    ggplot(data=df, aes(x=kmer, y=total)) +
      geom_bar(stat="identity",fill="indianred4",alpha=.7)+
      theme_minimal()

In this script we loop through our different folders and pick out the Log file with information on the total number of contigs, kmer length, N50 value, max contig length and total contig length. We then get the following plots:

Kmer v. Nodes/Number of Contigs

![](images/kmerNodes.PNG)

Kmer v. N50

![](images/kmerN50.PNG)

Kmer v. Max Contig Length

![](images/kmerMax.PNG)

Kmer v. Total Contig Length

![](images/kmerTotal.PNG)

Before we continue we should talk about the N50 value. To get this value you line up the contigs smallest to largest, and pick the contig length where half of the contigs would be that size or larger. This is sort of a measure of how complete your assembly is. So now that we understand this term we can make sense of these graphs. When chosing our best assembly we chose the kmer length that best balances all these metrics. We see that close to 30: the number of contigs decreases (indicating they a more contiguous sequence), the N50 value inceases(indicating a more complete assembly), the max contig length increases (indicating larger contigs and hence a more contiguous sequence). 

## References

1. [An Introduction to Genome Assembly](https://training.galaxyproject.org/training-material/topics/assembly/tutorials/general-introduction/tutorial.html)
2. [Quality Control](https://training.galaxyproject.org/training-material/topics/sequence-analysis/tutorials/quality-control/tutorial.html)

_________________________________________________________________________________________________________________________________________________________________________________

Next Workshop: [Variant Calling](../variantCalling/variantCalling.md)

[Back To DNA Workshops](../DNA.md)

[Back To The Main Page](../../index.md)
