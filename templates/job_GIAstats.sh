#!/bin/bash

#$ -cwd -V
#$ -l h_rt=12:00:00
#$ -pe smp 1
#$ -l h_vmem=4G
#$ -N "GIAstats"
#$ -m be
#$ -j y
#$ -M earjbar@leeds.ac.uk

date # start time

module purge
module load user
module load netcdf hdf5
module switch intel gnu

source $HOME/libs/utils.sh

MASK=$HOME/basin_mask.hdf5

for BASIN_ID in 0 1 2; do
    BASIN=$(getIMBIEbasin $BASIN_ID)
done

basin_stats="GIAstats/${BASIN}"

bash $HOME/libs/GIAstats.sh -m $MASK -b $BASIN plotfiles $basin_stats