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
# load defaults + bisicles + python:
module load intel
module load openmpi
module load user bisicles/gia #python/2.7.13
module load sge
module load licenses
module load python3
module load hdf5
module load netcdf
# switch compilers:
module switch intel gnu
# switch mpi:
module switch openmpi mvapich2
module load anaconda
source activate bisicles
# list loaded modules:
module list 2>&1

BASEDIR=$SGE_O_WORKDIR
PYDIR=$BASEDIR
export PYTHONPATH=$PYDIR
PYTHON=/home/home01/earjbar/.conda/envs/bisicles/bin/python
MV2_ENABLE_AFFINITY=0

#make plotfile directory if it doesn't exist
if [ ! -d "plotfiles" ] ; then
  \mkdir plotfiles
fi
if [ ! -d "Inputs" ] ; then
  \mkdir Inputs
fi
# save existing inputs file:
if [ -e "inputs" ] ; then
  \mv inputs Inputs/inputs.$(date '+%Y%m%d%H%M%S')
fi
 
# maximum time step:
max_time=10000

# set up input file:
\cp @INFILE inputs

plot_interval=10
coupling_interval=30

#if [ "$(ls -b plotfiles | wc -l)" -gt 1 ]; then
if [ -n "$(ls plotfiles)" ]; then
    current_len_zero_included=$(ls -l plotfiles/plot* | wc -l)
    sed -i "s/amr.restart_time = 0.0/#amr.restart_time = 0.0/g" inputs
    python python_timestepper.py >> lasttime.txt
    #ts=$(expr $current_len \* $plot_interval)
    str=$(grep "mostRecentPlotTime=" lasttime.txt)
    echo $str
    ts=${str#*=}
    rm lasttime.txt
    echo $ts
else
    current_len_zero_included=1
    ts=0
    echo "timestep 0"
fi

chk=$(\ls -tr chk*.hdf5 | tail -n1)

# max time step is current time step (-1, adds year to maxtime otherwise)
# + coupling interval (30):
max_ts=$((ts+30))
# update input file:
sed -i "s/amr.restart_file = chk.*.2d.hdf5/amr.restart_file = ${chk}/g" inputs
cat >> inputs <<EOF
main.maxTime = ${max_ts}
#main.maxStep = ${max_ts}
EOF

# run bisicles:
mpirun driver2d inputs

# tidy up
old_ts=$((ts-60))
rm -r poutfiles_$old_ts
mkdir poutfiles_$ts
if [ ! -d "poutfiles_prev_ts" ] ; then
  \mkdir poutfiles_prev_ts
fi
cp -r pout.AIS* poutfiles_prev_ts/
rm -r pout.AIS*

#run pdd and basal melt once bisicles has completed
module switch mvapich2 openmpi
mv smb.nc smb.$(date '+%Y%m%d%H%M%S').$ts.nc
rm smb.hdf5
echo "running coupler script..."
$PYTHON @PDDNAME >> python_log.txt
#rm Cthird*hdf5
#rm Cthird_elev_coupled.nc
#python bedFricCalculate.py 
NCTOAMR=$BISICLES_HOME/BISICLES/BISICLES/code/filetools/nctoamr2d.Linux*
$NCTOAMR smb.nc smb.hdf5 smb
##$NCTOAMR Cthird_elev_coupled.nc Cthird_elev_coupled.hdf5 Cthird

conda deactivate

# if current max time step is less than overall max time step:
if [ "${max_ts}" -lt "${max_time}" ] ; then
  # avoid job chaining bug on arc systems:
  export PATH=${SGE_O_PATH}
  unset SGE_STARTER_PLUGINS
  # submit next job:
  if [ 0 -lt $(ls core.d* 2>/dev/null | wc -w) ]; then
      echo "Core files generated, abort..."
  else
      qsub @JOB
  fi
fi

# end time:
date
