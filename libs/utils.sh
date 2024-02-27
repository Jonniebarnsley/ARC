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
        return "WAIS"
        ;;
    1)
        return "EAIS"
        ;;
    2)
        return "APIS"
        ;;
esac
}
