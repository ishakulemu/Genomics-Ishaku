#!/bin/bash/

mkdir Ishaku
wget https://github.com/HackBio-Internship/public_datasets/blob/main/Global_genome_structure_project/processed_plink_files/1_1-150000.ped?raw=true -O 1_1-150000.ped
wget https://github.com/HackBio-Internship/public_datasets/blob/main/Global_genome_structure_project/binary_plink_files/1_1-150000.bed?raw=true -O 1_1-150000.bed
wget https://github.com/HackBio-Internship/public_datasets/raw/main/Global_genome_structure_project/binary_plink_files/1_1-150000.bim
wget https://github.com/HackBio-Internship/public_datasets/raw/main/Global_genome_structure_project/binary_plink_files/1_1-150000.fam
plink --bfile 1_1-150000 --pca
ls
scp -P 10497 -r genomics@6.tcp.eu.ngrok.io:/home/genomics/Ishaku $PWD

#RSTUDIO
getwd()
setwd("/cloud/project/Ishaku/Ishaku/Ishaku")
eigenval = read.table("plink.eigenvec", header = F)
head(eigenval)
complete = read.table("complete_1000_genomes_sample_list_.tsv", header = T,sep = '\t')
head(complete)
View(eigenval)
View(complete)
IshakuFinaldata = merge(eigenval,complete, by.x = "V2", by.y = "Sample.name",all = F)
View(IshakuFinaldata)
install.packages("ggplot2")
library("ggplot2")
ggplot(data=IshakuFinaldata, aes(V3,V4,color = Superpopulation.code)) + geom_point()

