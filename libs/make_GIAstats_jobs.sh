#!/bin/bash

for run in $CONTROL/run*control; do

    name=$(basename $run)

    dir=$run/${name}_2lev_ref
    
    cd $dir
    rm -r GIAstats/Rignot
    job="$dir/job_GIAstats.${name}.sh"

    sed -e s/@JOBID/$name/ $HOME/templates/job_GIAstats.template.sh > $job
    qsub $job
done
