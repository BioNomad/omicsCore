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
