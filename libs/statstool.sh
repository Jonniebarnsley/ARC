#!/bin/bash

usage() { echo "Usage: $0 [-m <mask>] [-b <basin id>] <plotfile>" 1>&2; exit 1; }

STATS="/nobackup/earjo/gia_stats_exec/gia-stats2d"

# handle options
while getopts ":m:b:" option; do
    case "${option}" in
        m)  # specify mask
            MASK=${OPTARG}
            ;;
        b)  # specify basin number
            BASIN_ID=${OPTARG}
            ;;
        *)  # invalid option
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

# now apply the stats tool to the plotfile

# if no mask
if [ -z "${MASK}" ]; then
    "$STATS" "$FILE" 918.0 1028.0 9.81 0.0 # <rho_ice> <rho_seawater> <gravity> <sea_level>
    exit
fi

# if mask given but incorrect filepath
if [ ! -f "$MASK" ]; then
    echo "error: $MASK does not exist" 
    exit 1
fi

# otherwise
"$STATS" "$FILE" 918.0 1028.0 9.81 0.0 "$MASK" "$BASIN_ID"
