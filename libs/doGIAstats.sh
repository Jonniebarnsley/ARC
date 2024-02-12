#!/bin/bash

# script to generate GIAstats files for all plotfiles in a directory.
#
# inputs:
#   <plotfiles_path>    : path to plotfiles directory
#   <destination_path>  : path to GIAstats directory
#
# outputs:
#   None

source $HOME/libs/count_files.sh

EXEC="/nobackup/earjo/gia_stats_exec/gia-stats2d"

doGIAstats() {
    
    # usage clause    
    if [ "$#" -ne 2 ]; then
        echo "Usage: doGIAstats <plotfiles_path> <destination_path>"
        return 1
    fi

    local plotfiles="$1"
    local GIAstats="$2"
    
    # make GIAstats dir if it doesn't already exist
    mkdir -p $GIAstats
    
    local totalPlot=$(count_files "$plotfiles" 'plot.*.2d.hdf5')
    local totalGIA=$(count_files "$GIAstats" 'plot.*.GIAstats')
    
    # if plotfiles and GIAstats are the same size, stop
    if [ "$totalPlot" -eq "$totalGIA" ]; then
        return
    fi
    
    # otherwise, iterate over plotfiles
    local current=0
    for file in "$plotfiles"/plot.*.2d.hdf5; do
        
        ((current += 1)) # increment counter
        filename=$(basename "$file")
        statsfile="${filename%.2d.hdf5}.GIAstats"
        
        # if corresponding statsfile doesn't exist, make one
        if [ ! -e "$GIAstats/$statsfile" ]; then
            count="($current/$totalPlot)"
            echo "$count $filename ..."
            "$EXEC" "$file" 918.0 1028.0 9.81 0.0 # <p_ice> <p_seawater> <gravity> <sea_level>
            cat pout.0 >> "$GIAstats/$statsfile" # save output to statsfile
        fi
    done
}

