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
