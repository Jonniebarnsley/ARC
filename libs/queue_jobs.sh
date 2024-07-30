#!/bin/bash

ensemble="/nobackup/earjbar/Pliocene"

for i in {031..060}; do
    
    if [ $i -eq '048' ]; then
        continue
    fi

    run="run${i}"
    running=$(bash $HOME/libs/qstatFullJobNames.sh)
    run_dir="${ensemble}/${run}*/*"

    if grep -q "$run" <<< "$running"; then
        echo "$run in progress..."
    else
        cd $run_dir
        qsub "job.AIS-BH-GIA-exp-${i}.2lev.sh"
        cd ../..
    fi
done
