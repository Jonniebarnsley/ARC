#!/bin/bash

MASK=$HOME/basin_mask.hdf5

usage() { echo "Usage: $0 <run_directory>" 1>&2; exit 1; }

if [ "$#" -ne 1 ]; then
    usage
fi

run="$1"
name=$(basename $run_directory)
dir=$run/${name}_2lev_ref
plotfiles=$dir/plotfiles

for BASIN_ID in 0 1 2; do
    case $BASIN_ID in
        0)
            BASIN="WAIS"
            ;;
        1)
            BASIN="EAIS"
            ;;
        2)
            BASIN="APIS"
            ;;
    esac

    BASINstats=$dir/GIAstats/$BASIN
    bash $HOME/libs/GIAstats.sh -m $MASK -b $BASIN_ID $plotfiles $BASINstats
done