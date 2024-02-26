#!/bin/bash

# script to generate GIAstats files for all plotfiles in a directory.
#
# inputs:
#   <plotfiles_path>    : path to plotfiles directory
#   <destination_path>  : path to GIAstats directory

source $HOME/libs/count_files.sh

statstool() {

    local EXEC="/nobackup/earjo/gia_stats_exec/gia-stats2d"

    # handle option to include mask with -m
    is_mask=false
    while getopts ":m:" opt; do
        case "${opt}" in
            m)  is_mask=true
                MASK="${OPTARG}" ;;
            \?) echo "Invalid option: -${OPTARG}" >&2
                return 1 ;;
        esac
    done
    shift $((OPTIND - 1))

    local plotfile=$1

    if [[ $is_mask == true ]]; then
        echo "loading mask..."
        #"$EXEC" "$plotfile" 918.0 1028.0 9.81 0.0 "$MASK"
    else
        echo "doing stats for whole continent..."
        #"$EXEC" "$plotfile" 918.0 1028.0 9.81 0.0 # <rho_ice> <rho_seawater> <gravity> <sea_level>
    fi
}

doGIAstats() {
    
    # handle option to include mask with -m
    local is_mask=false
    while getopts ":m:" opt; do
        case $opt in
            m)  
                local is_mask=true
                local MASK="$OPTARG" ;;
            \?) 
                echo "Invalid option: -$OPTARG" >&2
                return 1 ;;
        esac
    done
    shift $((OPTIND - 1))

    # usage clause    
    if [ "$#" -ne 2 ]; then
        echo "Usage: doGIAstats <plotfiles_path> <destination_path>"
        return 1
    fi

    local plotfiles="$1"
    local GIAstats="$2"
    
    # make GIAstats dir if it doesn't already exist
    mkdir -p $GIAstats

    # if plotfiles and GIAstats are the same size, stop
    local totalPlot=$(count_files "$plotfiles" 'plot.*.2d.hdf5')
    local totalGIA=$(count_files "$GIAstats" 'plot.*.GIAstats')
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
            if $is_mask; then
                "$EXEC" "$file" 918.0 1028.0 9.81 0.0 "$MASK"
            else
                "$EXEC" "$file" 918.0 1028.0 9.81 0.0 # <rho_ice> <rho_seawater> <gravity> <sea_level>
            fi
            cat pout.0 >> "$GIAstats/$statsfile" # save output to statsfile
        fi
    done
}

