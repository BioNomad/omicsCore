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
