#!/bin/bash

usage() { echo "Usage: $0 [-m <mask>] [-b <basin>] <plotfile>" 1>&2; exit 1; }

STATS="/nobackup/earjo/gia_stats_exec/gia-stats2d"

# handle options for mask and basin
while getopts ":m:b:" option; do
    case "${option}" in
        m)
            MASK=${OPTARG}
            ;;
        b)
            BASIN=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# check args
if [ "$#" -ne 1 ]; then
    usage
fi

FILE="$1"

case $BASIN in
    0)  
        basin_name="WAIS" 
        ;;
    1)  
        basin_name="EAIS" 
        ;;
    2)  
        basin_name="APIS" 
        ;;
esac

# apply stats tool
if [ -z "${MASK}" ]; then
    echo "continent wide"
    #$STATS $FILE 918.0 1028.0 9.81 0.0 # <rho_ice> <rho_seawater> <gravity> <sea_level>
else
    echo "mask activated, basin $basin_name"
    #$STATS $FILE 918.0 1028.0 9.81 0.0 $MASK $BASIN
fi
