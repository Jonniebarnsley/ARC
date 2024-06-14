#!/bin/bash

usage() { echo "Usage: $0 nobackup/expire/<warn_file>" 1>&2; exit 1; }

# check args
if [ "$#" -ne 1 ]; then
    usage
fi

WARNING="$1"

cat $WARNING | while read file; do
    echo $file
    touch $file
done
