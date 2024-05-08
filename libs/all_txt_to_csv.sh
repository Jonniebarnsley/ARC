#!/bin/bash

module load anaconda
source activate postprocessing

for txt in $CONTROL/run*control/run*/summary_stats/Rignot/*_summary_stats.txt; do
    echo $(basename $txt)
    python $HOME/libs/summary_to_csv.py $txt
done

conda deactivate
