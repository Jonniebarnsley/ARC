#!/bin/bash

for run in $CONTROL/run*control; do

    name=$(basename $run)

    dir=$run/${name}_2lev_ref
    
    cd $dir

    job="$dir/job_GIAstats.${name}.sh"

    qsub $job

done
