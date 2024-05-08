#!/bin/bash

#$ -cwd -V
#$ -l h_rt=6:00:00
#$ -pe smp 10
#$ -l h_vmem=2G
#$ -N "aggregate_runs"
#$ -m be
#$ -M earjbar@leeds.ac.uk
#$ -j y

date # start time

module purge
module load user
module load parallel

NCORES=10
ENSEMBLE="/nobackup/earjo/AIS_PPE_control_ensemble"

parallel -j $NCORES 'bash AggregateRun.sh {}' ::: $ENSEMBLE/run*control

date
