#!/bin/bash

usage() { echo "Usage: $0 <run_directory>" 1>&2; exit 1; }

# usage clause
if [ "$#" -ne 1 ]; then
    usage
fi

dir="$1"
name=$(basename $dir)

if [[ $name == "run_data" ]]; then
    continue
fi

main_dir=$dir/${name}_2lev_ref
   
run_num=${name#*run}

GIAstats="$main_dir/GIAstats"
for basin_dir in $GIAstats/*/; do

    if [ ! -d $basin_dir ]; then
        continue
    fi

    basin=$(basename $basin_dir)
    filename="${basin}_${run_num}_summary_stats.txt"
    outfile=$main_dir/$filename
    echo "$filename"
    bash $HOME/libs/AggregateGIAstats.sh $basin_dir $outfile
done

