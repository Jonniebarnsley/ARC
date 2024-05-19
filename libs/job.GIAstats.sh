#!/bin/bash

#$ -cwd -V
#$ -l h_rt=12:00:00
#$ -pe smp 1
#$ -l h_vmem=4G
#$ -N "GIAstats"
#$ -m be
#$ -j y
#$ -M earjbar@leeds.ac.uk

# start time:
date

module purge
module load user
module load netcdf hdf5
module load parallel
module switch intel gnu

ENSEMBLE=/nobackup/earjo/AIS_PPE_control_ensemble

for run in $ENSEMBLE/run*control; do
    $HOME/libs/runGIAstats.sh $run
done
