#!/bin/bash
#$ -S /bin/bash
#$ -o /logs/
#$ -e /logs/
#$ -cwd
#$ -r y
#$ -j y
#$ -l mem_free=80G
#$ -l scratch=10G
#$ -l h_rt=36:00:00
#$ -t 1-4

#cd ./CM_AM_04
cd ./CM_AM_05
pwd


#sample=$(awk 'FNR == i {print}' i=${SGE_TASK_ID} CM_AM_04_samplesheet.txt)
sample=$(awk 'FNR == i {print}' i=${SGE_TASK_ID} CM_AM_05_samplesheet.txt)
echo "Sample run: " ${sample}

rm -r ${sample}_analysis

transcriptome="refdata-cellranger-mm10-3.0.0"

/wynton/group/ye/tools/cellranger-3.1.0/cellranger count \
--id=${sample}_analysis \
--fastqs=./ \
--sample=${sample} \
--transcriptome=${transcriptome} \
--jobmode=sge \
--chemistry=SC3Pv3 \

qstat -j $JOB_ID
