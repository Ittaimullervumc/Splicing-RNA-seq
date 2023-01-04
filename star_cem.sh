#!/bin/bash

module load STAR/2.7.10b
module load samtools/1.16.1

for prefix in $(cat cem.txt); do

        if [[ -s ${prefix}.Aligned.sortedByCoord.out.bam ]]; then

                echo "file is not empty: skipping sample ${prefix}"

        else

echo "now running STAR on ${prefix}"

STAR --runThreadN 16 \
--runMode alignReads \
--twopassMode Basic \
--quantMode GeneCounts \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 \
--alignIntronMin 20 \
--alignIntronMax 1000000 \
--alignMatesGapMax 100000 \
--outFilterType BySJout \
--genomeDir /net/beegfs/scratch/imuller/gencode_index_release42_hg3813 \
--readFilesIn ${prefix}_L001_R1_001.trim.fastq.gz,${prefix}_L002_R1_001.trim.fastq.gz,${prefix}_L003_R1_001.trim.fastq.gz,${prefix}_L004_R1_001.trim.fastq.gz ${prefix}_L001_R2_001.trim$
--alignEndsType EndToEnd \
--outSAMtype BAM SortedByCoordinate \
--sjdbOverhang 149 \
--readFilesCommand zcat \
--outFileNamePrefix ${prefix}. \

samtools index -b -@ 16 ${prefix}.Aligned.sortedByCoord.out.bam

fi

done
