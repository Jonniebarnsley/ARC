#!/bin/bash

#$ -cwd -V
#$ -l h_rt=02:00:00
#$ -pe smp @NCORES
#$ -l h_vmem=4G  #8G
#$ -N "@NAME"
#$ -m be
#$ -M earjbar@leeds.ac.uk
# start time:
date

# clear out modules:
module purge

module load sge
module load intel
module load openmpi
module load licenses
module load python3
module load hdf5
module load netcdf
# load defaults + bisicles + python:
module load user bisicles/gia #python/2.7.13
# switch compilers:
module switch intel gnu
# switch mpi:
module switch openmpi mvapich2
#module load anaconda
#source activate ismip6_ocean_forcing

# list loaded modules:
module list 2>&1

BASEDIR=$SGE_O_WORKDIR
PYDIR=$BASEDIR
export PYTHONPATH=$PYDIR

MV2_ENABLE_AFFINITY=0

#make plotfile directory if it doesn't exist
if [ ! -d "plotfiles_relax" ] ; then
  \mkdir plotfiles_relax
fi

# run bisicles:
mpirun driver2d @INFILE

# tidy up
if [ ! -d "poutfiles_init" ] ; then
  \mkdir poutfiles_init
fi
cp -r pout.* poutfiles_init/
rm -r pout.*

source @wrapper
# end time:
date
