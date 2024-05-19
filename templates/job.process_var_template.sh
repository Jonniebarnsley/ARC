#!/bin/bash

#$ -cwd -V
#$ -l h_rt=12:00:00
#$ -pe smp 10
#$ -l h_vmem=1G
#$ -N "@VAR"
#$ -m be
#$ -M earjo@leeds.ac.uk
# start time:
date
# clear out modules:
module purge

module load anaconda
module unload python-libs
source activate postprocessing
module load parallel
NCORES=10
export PYTHONPATH="${PYTHONPATH}:/home/home01/earjbar/.conda/envs/postprocessing/"

#parallel -j $NCORES --dry-run echo {} ';' 'python generate_compressed_output_v1.py {} >> ProcLogs/{}_outputs.txt' ::: run*cosmos run*cesm
parallel -j $NCORES 'python generate_compressed_output_plotsAllSameDir_specVar.py {} @VAR >> ProcLogs/{}_outputs.txt' ::: run*control

