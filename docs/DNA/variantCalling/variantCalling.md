# Variant Calling

Compiling a reference sequence does not mean that sequence is the same across all orgainisms in that species. In fact the genome can vary significantly depending on your race, age and general environment. So when calling a DNA variant it is important to keep that in mind. Often times in diseases, like cancer which we will be talking about today, mutations are picked up just through living and not by some inheritance mechanism. These "picked up" mutations are called **somatic mutations** and the ones you inherit and can pass on are called **germline mutations**. 

The genomic landscape in tumor is complicated and in addition to variants being acquired, tumors can gain or lose copies of a variant that would otherwise be heterozygous in a normal individual. This is called **loss of heterozygosity** and it is pretty common in tumor suppressor genes - wherein a loss here would leave it susceptible to mutation and hence inactivation. The identification of what is a heterozyguos loss and what is germline/somatic relies on a match between samples. So for one patient you need their tumor and a normal tissue sample. This is called a matched normal. Let's get to it then!

## Quality Control

## References

1. [Loss of Heterozygosity](https://en.wikipedia.org/wiki/Loss_of_heterozygosity)
2. [Identification of somatic and germline variants from tumor and normal sample pairs](https://training.galaxyproject.org/training-material/topics/variant-analysis/tutorials/somatic-variants/tutorial.html)
___________________________________________________________________________________________________________________________________________________________________________________

Next Workshop: [ATAC-seq](atacSeq/atacSeq.md)

[Back To DNA Workshops](../DNA.md)

[Back To The Main Page](../../index.md)