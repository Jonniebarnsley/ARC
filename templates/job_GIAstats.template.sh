#!/bin/bash

#$ -cwd -V
#$ -l h_rt=6:00:00
#$ -pe smp 1
#$ -l h_vmem=2G
#$ -N "@JOBID_stats"
#$ -m be
#$ -j y
#$ -M earjbar@leeds.ac.uk

date # start time

module purge
module load user
module load netcdf hdf5
module switch intel gnu

source $HOME/libs/utils.sh

MASK=$HOME/data/ISMIP_basin_mask_16km.hdf5

for BASIN_ID in 0 1 2; do
    BASIN=$(getIMBIEbasin $BASIN_ID)
    basin_stats="GIAstats/${BASIN}"

    bash $HOME/libs/GIAstats.sh -m $MASK -b $BASIN_ID plotfiles $basin_stats
done
