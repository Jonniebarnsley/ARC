#!/bin/bash

# script that applies reduce_plotfiles.sh to a run directory. The main purpose
# of this script is to set up the runs so that they can easily be processed in
# parallel using the parallel gnu library.

 usage() { "Usage: $0 <run_directory>" 1>&2; exit 1; }

 # check inputs
 if [ "$#" -ne 1 ]; then
     usage
 fi

# get run directory path and name
run=$1
run_name=$(basename $run)

# relevant directory paths
plotfiles="$run/${run_name}_2lev_ref/plotfiles"
reduced="$run/${run_name}_2lev_ref/plotfiles_reduced"

# print to console and run script
echo $run_name
bash reduce_plotfiles.sh $plotfiles $reduced


