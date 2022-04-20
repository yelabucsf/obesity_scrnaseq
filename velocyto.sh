#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -r y
#$ -j y
#$ -l mem_free=80G
#$ -l scratch=10G
#$ -l h_rt=36:00:00
#$ -t 1-4

conda activate velocyto

#cd ./CM_AM_04
cd ./CM_AM_05
pwd


#sample=$(awk 'FNR == i {print}' i=${SGE_TASK_ID} CM_AM_04_samplesheet.txt)
sample=$(awk 'FNR == i {print}' i=${SGE_TASK_ID} CM_AM_05_samplesheet.txt)
echo "Sample run: " ${sample}

gene_anno="refdata-cellranger-mm10-3.0.0_genes.gtf"
gene_mask="mm10_repeatMask.gtf"

data_prepath="./"
data_postpath="_analysis/outs/"

velocyto run \
 ${data_prepath}${sample}${data_postpath}possorted_genome_bam.bam \
 ${gene_anno} \
 -m ${gene_mask} \
 -b ${data_prepath}${sample}${data_postpath}filtered_feature_bc_matrix/barcodes.tsv.gz \
 -o ${sample}_velocyto

qstat -j $JOB_ID
