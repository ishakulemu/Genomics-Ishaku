#!/bin/bash/

mkdir stageII && cd stageII
sudo apt-get install fastp
sudo apt-get install fastqc
sudo apt-get install bwa
sudo apt-get install samtools
conda install -c bioconda -c conda-forge multiqc
sudo apt-get install bcftools
mkdir -p daatah/reference_G
ls
cd daatah
ls
cd ../
wget https://zenodo.org/record/2582555/files/hg19.chr5_12_17.fa.gz -o daatah/reference_G/hg19.chr5_12_17.fa.gz
cd daatah
ls
cd reference_G
ls
cd ../../
gunzip daatah/reference_G/hg19.chr5_12_17.fa.gz
wget https://zenodo.org/record/2582555/files/SLGFSK-N_231335_r1_chr5_12_17.fastq.gz -O SLGFSK-N_231335_r1_chr5_12_17.fastq.gz
wget https://zenodo.org/record/2582555/files/SLGFSK-N_231335_r2_chr5_12_17.fastq.gz -O SLGFSK-N_231335_r2_chr5_12_17.fastq.gz
wget https://zenodo.org/record/2582555/files/SLGFSK-T_231336_r1_chr5_12_17.fastq.gz -O SLGFSK-T_231336_r1_chr5_12_17.fastq.gz
wget https://zenodo.org/record/2582555/files/SLGFSK-T_231336_r2_chr5_12_17.fastq.gz -O SLGFSK-T_231336_r2_chr5_12_17.fastq.gz
ls
fastp -i SLGFSK-N_231335_r1_chr5_12_17.fastq.gz -I SLGFSK-N_231335_r2_chr5_12_17.fastq.gz -o SLGFSK-N_231335_r1_chr5_12_17.fastq.gz -O SLGFSK-N_231335_r2_chr5_12_17.fastq.gz
ls
fastp -i SLGFSK-T_231336_r1_chr5_12_17.fastq.gz -I SLGFSK-T_231336_r2_chr5_12_17.fastq.gz -o SLGFSK-T_231336_r1_chr5_12_17.fastq.gz -O SLGFSK-T_231336_r2_chr5_12_17.fastq.gz
ls
mkdir qc_reads
fastqc SLGFSK-N_231335_r1_chr5_12_17.fastq.gz -o qc_reads/
fastqc SLGFSK-N_231335_r2_chr5_12_17.fastq.gz -o qc_reads/
fastqc SLGFSK-T_231336_r1_chr5_12_17.fastq.gz -o qc_reads/
fastqc SLGFSK-T_231336_r2_chr5_12_17.fastq.gz -o qc_reads/
cd qc_reads
ls
cd ../
multiqc qc_reads
ls
cd qc_reads
ls
gunzip SLGFSK-N_231335_r1_chr5_12_17_fastq.gz
gunzip SLGFSK-N_231335_r2_chr5_12_17.fastq.gz
gunzip SLGFSK-T_231336_r1_chr5_12_17.fastq.gz
gunzip SLGFSK-T_231336_r2_chr5_12_17.fastq.gz
ls
cd ../
mkdir -p resolts/sam resolts/bam resolts/bcf resolts/veecf
cd resolts
ls
cd ../
cd daatah/
ls
cd reference_G
ls
cd ../../
bwa index daatah/reference_G/hg19.chr5_12_17.fa
cd daatah
ls
cd reference_G
ls
cd ../../
bwa
bwa mem daatah/reference_G/hg19.chr5_12_17.fa SLGFSK-N_231335_r1_chr5_12_17.fastq SLGFSK-N_231335_r2_chr5_12_17.fastq.gz > resolts/sam/SLGFSK-N.aligned.sam
cd resolts
ls
cd sam
ls
cd ../../
bwa mem daatah/reference_G/hg19.chr5_12_17.fa SLGFSK-T_231336_r1_chr5_12_17.fastq SLGFSK-T_231336_r2_chr5_12_17.fastq > resolts/sam/SLGFSK-T.aligned.sam
samtools
samtools view -S -b resolts/sam/SLGFSK-N.aligned.sam > resolts/bam/SLGFSK-N.aligned.bam
samtools view -S -b resolts/sam/SLGFSK-T.aligned.sam > resolts/bam/SLGFSK-T.aligned.bam
cd resolts
ls
cd bam
ls
cd ../../
samtools sort -o resolts/bam/SLGFSK-N.aligned.sorted.bam resolts/bam/SLGFSK-N.aligned.bam
samtools sort -o resolts/bam/SLGFSK-T.aligned.sorted.bam resolts/bam/SLGFSK-T.aligned.bam
cd resolts
ls
cd bam
ls
cd ../../
samtools flagstat resolts/bam/SLGFSK-N.aligned.sorted.bam
samtools flagstat resolts/bam/SLGFSK-T.aligned.sorted.bam
bcftools
bcftools mpileup -O b -o resolts/bcf/SLGFSK-N_raw.bcf --no-reference -f hg19.chr5_12_17.fa resolts/bam/SLGFSK-N.aligned.sorted.bam
ls
cd resolts
ls
cd bcf
ls
ls -lh
cd ../../
bcftools mpileup -O b -o resolts/bcf/SLGFSK-T_raw.bcf --no-reference -f hg19.chr5_12_17.fa resolts/bam/SLGFSK-T.aligned.sorted.bam
bcftools call --ploidy 1 -m -v -o resolts/veecf/SLGFSK-N_variants.veecf resolts/bcf/SLGFSK-N_raw.bcf
ls
cd resolts
ls
cd veecf
ls
cd ../../
bcftools call --ploidy 1 -m -v -o resolts/veecf/SLGFSK-T_variants.veecf resolts/bcf/SLGFSK-T_raw.bcf
cd resolts
ls
cd veecf
ls
cd ../../
vcfutils.pl varFilter resolts/veecf/SLGFSK-N_variants.veecf > resolts/veecf/SLGFSK-N_final_variants.veecf
cd resolts
cd veecf
ls
cd ../../
vcfutils.pl varFilter resolts/veecf/SLGFSK-T_variants.veecf > resolts/veecf/SLGFSK-T_final_variants.veecf
less -S resolts/veecf/SLGFSK-N_final_variants.veecf
less -S resolts/veecf/SLGFSK-T_final_variants.veecf 
cd resolts
cd bam
ls
cd ../../
samtools index resolts/bam/SLGFSK-N.aligned.sorted.bam
samtools index resolts/bam/SLGFSK-T.aligned.sorted.bam
ls
cd daatah
ls
cd reference_G
ls
cd ../../
samtools tview resolts/bam/SLGFSK-N.aligned.sorted.bam
samtools tview resolts/bam/SLGFSK-T.aligned.sorted.bam

# my pc secuirity system could not allow me download IGV, hence I didn't execute that bit.
