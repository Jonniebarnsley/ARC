#!/bin/bash

#$ -cwd -V
#$ -l h_rt=24:00:00
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

MASK=$HOME/data/zwally_basins_extended_16km.hdf5

for BASIN_ID in {1..27}; do
    basin_stats="GIAstats/Zwally/${BASIN_ID}"
    bash $HOME/libs/GIAstats.sh -m $MASK -b $BASIN_ID plotfiles $basin_stats
done
