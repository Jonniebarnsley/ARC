#!/bin/bash

#$ -cwd -V
#$ -l h_rt=02:00:00
#$ -l nodes=1
#$ -N "@JOBID"
#$ -m be
#$ -M earjbar@leeds.ac.uk
#$ -j y

date # start time

# prepare modules
module purge
module load user
module load bisicles/gia
module load python3 netcdf hdf5

module switch intel gnu # switch compilers
module switch openmpi mvapich2 # switch mpi

module load anaconda
source activate bisicles

module list

# environment variables
BASEDIR=$SGE_O_WORKDIR
PYDIR=$BASEDIR
export PYTHONPATH=$PYDIR

PYTHON=/home/home01/earjbar/.conda/envs/bisicles/bin/python
NCTOAMR=$BISICLES_HOME/BISICLES/BISICLES/code/filetools/nctoamr2d.Linux*

MV2_ENABLE_AFFINITY=0

# prepare directories
mkdir -p plotfiles
mkdir -p outputfiles
mkdir -p inputs_history
mkdir -p smb_history

# save old inputs and start new inputs file:
mv inputs inputs_history/inputs.$(date '+%Y%m%d%H%M').$ts
cp inputs.@NAME inputs

# establish the timestep
last_plotfile=$(ls -tr plotfiles/plot.*.hdf5 | tail -n1)
if [ -n "$last_plotfile" ]; then
    sed -i "/amr.restart_time = 0.0/d" inputs
    timestep=$(python get_timestep.py plotfiles/$last_plotfile)
else
    timestep=0
fi

coupling_interval=30
next_coupling=$((timestep+coupling_interval))

# update input file:
last_checkpoint=$(ls -tr checkpoints/chk.*.hdf5 | tail -n1)
echo "amr.restart_file = checkpoints/${last_checkpoint}" >> inputs
echo "main.maxTime = $next_coupling" >> inputs

# run BISICLES:
echo "running BISICLES on inputs..."
mpirun driver2d inputs
echo "BISICLES done"

# tidy up
rm pout.*
mv chk.*.hdf5 checkpoints
ls -t @JOBID.o* | tail -n +2 | -I{} mv {} outputfiles

ls @NAME.o*

# Calculate surface mass balance
mv smb.nc smb_history/smb.$(date '+%Y%m%d%H%M').$ts.nc
rm smb.hdf5
echo "Calculating SMB..."
$PYTHON calc_smb.@NAME.py
$NCTOAMR smb.nc smb.hdf5 smb
echo "SMB done"
conda deactivate

# submit next job or stop if completed max time
max_time=10000
if [ "${next_coupling}" -lt "${max_time}" ]; then

  # avoid job chaining bug on arc systems:
  export PATH=${SGE_O_PATH}
  unset SGE_STARTER_PLUGINS

  # check for any crashes
  if [ -n "$(ls core.* 2>/dev/null)" ]; then
      echo "Core files generated, abort..."
      rm core.*
  else
      qsub job.@NAME.sh
  fi
fi

date # end time