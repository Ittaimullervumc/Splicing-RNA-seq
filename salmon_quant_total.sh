
#!/bin/bash
module load java/jre1.8.0_281

cd /net/beegfs/scratch/imuller/UAE_fastq_new/UAE90_fastq

ls -h *.gz | awk -F '_' '{print $1}' | sort | uniq > ID_2.txt
for id in $(cat ID2.txt);

do

salmon quant --threads 16 \
--index /net/beegfs/scratch/imuller/genomereference/salmon_index \
--validateMappings \
--libType A \
--gcBias \
--output /net/beegfs/scratch/imuller/salmon_output_total_14122022/$id \
-1 ${id}_L001_R1.trim.fastq.gz ${id}_L002_R1.trim.fastq.gz ${id}_L003_R1.trim.fastq.gz /net/beegfs/scratch/imuller/UAE_fastq_oldrun/${id}*R1_001.fastq.gz \
-2 ${id}_L001_R2.trim.fastq.gz ${id}_L002_R2.trim.fastq.gz ${id}_L003_R2.trim.fastq.gz /net/beegfs/scratch/imuller/UAE_fastq_oldrun/${id}*R2_001.fastq.gz

done

cd /net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12

ls -h *.gz | awk -F '_' '{print $1}' | sort | uniq > ID_UAE.txt
for id in $(cat ID_UAE.txt);

do
salmon quant --threads 16 \
--index /net/beegfs/scratch/imuller/genomereference/salmon_index \
--validateMappings \
--libType A \
--gcBias \
--output /net/beegfs/scratch/imuller/salmon_output_total_14122022/$id \
-1 ${id}*_L001_R1_001.trim.fastq.gz ${id}*_L002_R1_001.trim.fastq.gz ${id}*_L003_R1_001.trim.fastq.gz ${id}*_L004_R1_001.trim.fastq.gz /net/beegfs/scratch/imuller/UAE_fastq_oldrun/${id}*R1_001.fastq.gz \
-2 ${id}*_L001_R2_001.trim.fastq.gz ${id}*_L002_R2_001.trim.fastq.gz ${id}*_L003_R2_001.trim.fastq.gz ${id}*_L004_R2_001.trim.fastq.gz /net/beegfs/scratch/imuller/UAE_fastq_oldrun/${id}*R2_001.fastq.gz

done
