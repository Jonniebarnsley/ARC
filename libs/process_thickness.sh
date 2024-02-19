#!/bin/bash

#$ -cwd -V
#$ -l h_rt=12:00:00
#$ -pe smp 10
#$ -l h_vmem=4G
#$ -N "process_thickness"
#$ -m be
#$ -M earjbar@leeds.ac.uk
# start time:
date
# clear out modules:
module purge

module load anaconda
module unload python-libs
source activate postprocessing
module load parallel
NCORES=10
ENSEMBLE="/nobackup/earjo/AIS_PPE_control_ensemble"
export PYTHONPATH="${PYTHONPATH}:/home/home01/earjbar/.conda/envs/postprocessing/"

parallel -j $NCORES 'python run_to_netcdf.py {} thickness' ::: $ENSEMBLE/run*control

