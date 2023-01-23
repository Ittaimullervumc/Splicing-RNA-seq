
#!/bin/bash

module load rmats/4.1.2
module load samtools/1.16.1

# for prefix in $(cat cem.txt); do

#       if [[ -s ${prefix}.Aligned.sortedByCoord.out.bam ]]; then

#               echo "file is not empty: skipping sample ${prefix}"

#        else

echo "now running rMATS on $(cat cem.txt CBD6250pos.txt)"

rmats.py \
--b1 cem.txt \
--b2 CBD6250neg.txt \
--gtf /net/beegfs/scratch/imuller/genomereference/gencode.v42.chr_patch_hapl_scaff.annotation.gtf \
-t paired --readLength 150 \
--nthread 16 \
--od CEMWTvs_CBD6250neg \
--tmp tmp_output

