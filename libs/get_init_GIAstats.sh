#!/bin/bash

# applies the stats tool to the first relaxation run plotfile of the first run
# in order to get the initial state for GIAstats

usage() { echo "Usage: $0 <ensemble_path>" 1>&2; exit 1; }

# check args
if [ "$#" -ne 1 ]; then
    usage
fi

ensemble=$1

run001=$ensemble/run001_*/run001_*_2lev_ref
plotfiles_relax=$run001/plotfiles_relax
init_plotfile=$(ls $plotfiles_relax | head -n 1)
echo $init_plotfile

outdir=$ensemble/GIAstats_init
mkdir -p $outdir

source $HOME/libs/utils.sh
for basin_id in {0..18}; do
    basin=$(getRignotbasin $basin_id)
    outfile=$outdir/Rignot_${basin}_init_stats.txt
    echo $outfile
    bash $HOME/libs/statstool.sh -m $HOME/data/rignot_basins_16km.hdf5 -b $basin_id $plotfiles_relax/$init_plotfile
    cat pout.0 >> $outfile
done

for basin_id in {1..27}; do
    outfile=$outdir/Zwally_${basin_id}_init_stats.txt
    echo $outfile
    bash $HOME/libs/statstool.sh -m $HOME/data/zwally_basins_extended_16km.hdf5 -b $basin_id $init_plotfile
    cat pout.0 >> $outfile
done



