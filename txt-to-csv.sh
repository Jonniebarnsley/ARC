#!/bin/bash

for txt in $CONTROL/run*control/run*/APIS_*_control_summary_stats.txt; do
    echo $(basename $txt)
    python $HOME/libs/summary_to_csv.py $txt
done
