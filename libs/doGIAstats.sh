#!/bin/bash

# script to generate GIAstats files for all plotfiles in a directory.
#
# inputs:
#   <plotfiles_path>    : path to plotfiles directory
#   <destination_path>  : path to GIAstats directory

source $HOME/libs/utils.sh

usage() { echo "Usage: $0 [-m <mask>] [-b <basin>] <plotfiles_directory> <stats_directory>" 1>&2; exit 1; }

# handle option to include mask and basin
while getopts ":m:b:" option; do
    case $option in
        m)  
            MASK="$OPTARG"
            ;;
        b)
            BASIN_ID="$OPTARG"
            ;;
        *) 
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

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

# check args    
if [ "$#" -ne 2 ]; then
    usage
fi

plotfiles="$1"
GIAstats="$2"

# make GIAstats dir if it doesn't already exist
mkdir -p $GIAstats

# if plotfiles and GIAstats are the same size, stop
totalPlot=$(count_files "$plotfiles" 'plot.*.2d.hdf5')
totalGIA=$(count_files "$GIAstats" 'plot.*.GIAstats')
if [ "$totalPlot" -eq "$totalGIA" ]; then
    exit 1
fi

# otherwise, iterate over plotfiles
current=0
for file in "$plotfiles"/plot.*.2d.hdf5; do
    
    ((current += 1)) # increment counter
    count="(${current}/${totalPlot})"

    filename=$(basename "$file")
    statsfile="${GIAstats}/${filename%.2d.hdf5}.GIAstats"

    # if corresponding statsfile doesn't exist, make one
    if [ ! -e "${statsfile}" ]; then

        # check for mask
        if [ -z "${MASK}" ]; then
            echo "${count} ${filename} ..."
            bash statstool.sh $file
            #"$EXEC" "$file" 918.0 1028.0 9.81 0.0
            
        else
            echo "${BASIN} ${count} ${filename} ..."
            bash statstool.sh -m $MASK -b $BASIN_ID $file
            #"$EXEC" "$file" 918.0 1028.0 9.81 0.0 "$MASK" "$BASIN_ID"
        fi
        
        cat pout.0 >> "$GIAstats/$statsfile" # save output to statsfile
    fi
done


