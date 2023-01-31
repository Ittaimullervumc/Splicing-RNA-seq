
#!/bin/bash
##Modified STAR command for combining the old and new sequencing run

module load STAR/2.7.10b
module load samtools/1.16.1

for prefix in $(cat ID.txt); do

        if [[ -s ${prefix}.Aligned.sortedByCoord.out.bam ]]; then

                echo "file is not empty: skipping sample ${prefix}"

        else

echo "now running STAR on ${prefix}"
dir1="/net/beegfs/scratch/imuller/UAE_fastq_oldrun/${prefix}*R1*"
dir2="/net/beegfs/scratch/imuller/UAE_fastq_oldrun/${prefix}*R2*"

dir3="/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/${prefix}*_L001_R1*"
dir4="/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/${prefix}*_L002_R1*"
dir5="/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/${prefix}*_L003_R1*"
dir6="/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/${prefix}*_L004_R1*"

dir7="/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/${prefix}*_L001_R2*"
dir8="/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/${prefix}*_L002_R2*"
dir9="/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/${prefix}*_L003_R2*"
dir10="/net/beegfs/scratch/imuller/UAE_fastq_new/UAE120_fastq/fastq_files_UAE12/${prefix}*_L004_R2*"


STAR --runThreadN 16 \
--runMode alignReads \
--twopassMode Basic \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 \
--alignIntronMin 20 \
--alignIntronMax 1000000 \
--alignMatesGapMax 100000 \
--outFilterType BySJout \
--genomeDir /net/beegfs/scratch/imuller/gencode_index_release42_hg3813 \
--readFilesIn $(echo $dir1),$(echo $dir3),$(echo $dir4),$(echo $dir5),$(echo $dir6) $(echo $dir2),$(echo $dir7),$(echo $dir8),$(echo $dir9),$(echo $dir10) \
--alignEndsType EndToEnd \
--outSAMtype BAM SortedByCoordinate \
--sjdbOverhang 149 \
--readFilesCommand zcat \
--outFileNamePrefix ${prefix}. \

samtools index -b -@ 16 ${prefix}.Aligned.sortedByCoord.out.bam

fi

done
