#!/bin/bash

usage() { echo "Usage: $0 <ensemble_path>" 1>&2; exit 1; }

# usage clause
if [ "$#" -ne 1 ]; then
    usage
fi

ENSEMBLE="$1"

for run in $ENSEMBLE/run*/run*; do

    if [[ $dir == *"DEPR"*"CATED"* ]]; then
        continue
    fi

    if [ $(dirname $dir) = "$ENSEMBLE/run_data"]; then
        continue
    fi

    GIAstats=$dir/GIAstats

    for basin in $GIAstats; do

        if [ ! -d $basin ]; then
            continue
        fi

        outfile="$dir/${basin}_summary_stats.txt"
        echo "$outfile"
        #bash $HOME/libs/AggregateGIAstats.sh $basin $outfile
    done
done