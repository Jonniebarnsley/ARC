#!/bin/bash

module load anaconda
source activate postprocessing

for txt in $CONTROL/run*control/run*/*_summary_stats.txt; do
    python $HOME/libs/summary_to_csv.py $txt
done

conda deactivate
