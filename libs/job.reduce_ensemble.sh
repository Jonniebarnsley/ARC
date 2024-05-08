#!/bin/bash

#$ -cwd -V
#$ -l h_rt=12:00:00
#$ -pe smp 10
#$ -l h_vmem=2G
#$ -N "reduce_ensemble"
#$ -m be
#$ -M earjbar@leeds.ac.uk
#$ -j y

date # start time

# prepare modules
module purge
module load user
module load bisicles/gia
module load netcdf hdf5
module load parallel
module switch intel gnu

NCORES=10
ENSEMBLE=$CONTROL

parallel -j $NCORES 'bash reduce_run.sh {}' ::: $ENSEMBLE/run*control

date # end time
