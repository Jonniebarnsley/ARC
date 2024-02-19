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
export PYTHONPATH="${PYTHONPATH}:/home/home01/earjbar/.conda/envs/postprocessing/"
echo $PYTHONPATH

#parallel -j $NCORES --dry-run echo {} ';' 'python generate_compressed_output_v1.py {} >> ProcLogs/{}_outputs.txt' ::: run*cosmos run*cesm
<<<<<<< HEAD
parallel -j $NCORES 'python generate_compressed_output_plotsAllSameDir_specVar.py {} thickness >> ProcLogs/{}_outputs.txt' ::: run*control

=======
parallel -j $NCORES 'python generate_compressed_output_plotsAllSameDir_specVar.py {} thickness >> ProcLogs/{}_outputs.txt' ::: run*control
>>>>>>> 8e16f42c029c89101e0b737549c589fed8f21fb3
