#!/bin/bash/

module purge
module load sge
module load python3
module load gnu
module load mvapich2
module load bisicles/gia
#module switch intel gnu
module load anaconda
source activate bisicles
NCTOAMR=$BISICLES_HOME/BISICLES/BISICLES/code/filetools/nctoamr2d.Linux.*
PYTHON=/home/home01/earjbar/.conda/envs/bisicles/bin/python
if [ ! -f "smb.hdf5" ] ; then
    $PYTHON init_smb.ensemble-071.py
    #convert initial smb file to hdf5
    $NCTOAMR smb.nc smb.hdf5 smb
    #$NCTOAMR Cthird_elev_coupled.nc Cthird_elev_coupled.hdf5 Cthird
fi
conda deactivate
qsub job.ensemble-071.sh
