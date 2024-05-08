#!/bin/bash

usage() { echo "Usage: $0 <run_directory>" 1>&2; exit 1; }

# usage clause
if [ "$#" -ne 1 ]; then
    usage
fi

dir="$1"

run=$(basename $dir) # e.g. run001_control
if [[ $run == "run_data" ]]; then
    continue
fi

# main data directory for run
main=$dir/${run}_2lev_ref

# iterate over Zwally and Rignot basins
for basin_dir in $main/GIAstats/{Zwally,Rignot}/*/; do
    
    # skip anything that isn't a basin directory
    if [ ! -d $basin_dir ]; then
        continue
    fi
    
    # get mask name (Zwally or Rignot) and basin ID
    mask=$(basename "$(dirname $basin_dir)")
    basin=$(basename $basin_dir)
    
    # set up directory for storing summary stats
    summary_dir="${main}/summary_stats/${mask}"
    mkdir -p $summary_dir
    
    # set up summary stats filename
    filename="${mask}_${basin}_${run}_summary_stats.txt"
    echo "$filename"
    
    # Aggregate basin directory to file
    outfile=$summary_dir/$filename
    bash $HOME/libs/AggregateGIAstats.sh $basin_dir $outfile
done

