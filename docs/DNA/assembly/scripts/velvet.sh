#!/bin/bash

# Assemble our reads #

# Break into k-mers with a length of 29
velveth velvet_29 29 -fmtAuto -create_binary -shortPaired -separate ./trim/mutant_R1_val_1.fq ./trim/mutant_R2_val_2.fq

# Assemble into a contig fasta
velvetg velvet_29
