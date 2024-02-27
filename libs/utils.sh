#!/bin/bash

# function to count the number of files in a 
# directory which match a given pattern.

count_files() {

    local directory="$1"
    local pattern="$2"
    find "$directory" -maxdepth 1 -type f -name "$pattern" | wc -l
}

getIMBIEbasin() {

    local ID="$1"
    case $ID in
    0)
        echo "WAIS"
        ;;
    1)
        echo "EAIS"
        ;;
    2)
        echo "APIS"
        ;;
esac
}
