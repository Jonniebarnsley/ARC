#!/bin/bash

#$ -cwd -V
#$ -l h_rt=00:30:00
#$ -pe smp 12
#$ -l h_vmem=4G
#$ -N "parallel_aggregate"
#$ -m e
#$ -M earjbar@leeds.ac.uk
#$ -j y

module puge
module load user
module load parallel

# job script goes here

parallel -j 24 'bash $HOME/libs/AggregateRun.sh {}' ::: $CONTROL/run*control 
