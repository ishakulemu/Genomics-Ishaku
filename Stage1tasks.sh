#!/bin/bash/
	 
	sudo apt-get install fastp
    	sudo apt-get install fastqc
    	sudo apt-get install bwa
    	sudo apt-get install samtools
    	conda install -c bioconda -c conda-forge multiqc
    	fastp
	fastqc
	bwa
	samtools
	multiqc
    	wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R1.fastq.gz?raw=true -O ACBarrie_R1.fastq.gz
    	wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R2.fastq.gz?raw=true -O ACBarrie_R2.fastq.gz
    	wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R1.fastq.gz?raw=true -O Baxter_R1.fastq.gz
    	wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Baxter_R2.fastq.gz?raw=true -O Baxter_R2.fastq.gz
    	ls
    	mkdir outpuut_reads
    	fastp -i ACBarrie_R1.fastq.gz -I ACBarrie_R2.fastq.gz -o ACBarrie_R1.fastq.gz -O ACBarrie_R2.fastq.gz 
    	fastp -i Baxter_R1.fastq.gz -I Baxter_R2.fastq.gz -o Baxter_R1.fastq.gz -O Baxter_R2.fastq.gz 
    	fastqc ACBarrie_R1.fastq.gz -o outpuut_reads/
    	fastqc ACBarrie_R2.fastq.gz -o outpuut_reads/
    	fastqc Baxter_R1.fastq.gz -o outpuut_reads/
    	fastqc Baxter_R2.fastq.gz -o outpuut_reads/
    	cd outpuut_reads/
    	ls
    	cd ../
    	multiqc outpuut_reads/
    	sudo apt-get install bbtools
    	ls
    	cd outpuut_reads/
    	ls
    	cd ../
    	ls
    	mv reference.fasta outpuut_reads/
    	cd outpuut_reads/
    	ls
    	cd ../
    	bwa index outpuut_reads/reference.fasta
    	cd outpuut_reads/
    	ls
    	cd ../
    	mkdir aligned
    	ls
    	bwa mem outpuut_reads/reference.fasta Baxter_R1.fastq.gz Baxter_R2.fastq.gz > aligned/Baxter.sam
    	cd aligned
    	ls
    	cd ../
    	samtools
	cd aligned
	samtools view -S -b Baxter.sam > Baxter.bam
    	ls
    	ls -lh
    	samtools view Baxter.bam | less
    	samtools view Baxter.bam | head
	samtools sort Baxter.bam -o Baxter.sorted.bam
	ls
    #done
    