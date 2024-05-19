#!/bin/bash/

#job_names=$(source qstatFullJobNames.sh | awk '{print $3}')

#for job in $job_names; do

#    plotfiles_dir="./$job/${job}_2lev_ref/plotfiles"
#    file_count=$(ls -1 "$plotfiles_dir" | wc -l)
#    years_complete=$((30*$file_count))
#    echo "$job has completed $years_complete years"
#done

running_jobs=$(source qstatFullJobNames.sh | awk '{print $3}')

#for EXPT in 1 2 3 5 6 7 8 10 11 12 13 14 15 16 17 18 19 20 21 23 24 29 30 33 34 35 37 42 43 46 49 51 52 57 59; do
#for EXPT in 61 62 64 66 67 68 70 73 74 76 77 78 79 80 82 84 85 86 87 88 89 90 91 97 98 102 103 104 105 107 108 109 110 111 112 114 115 117 118; do
for EXPT in {1..120}; do

    EXPT=$(printf "%03d" "$EXPT")
    job="run${EXPT}_control"
    plotfiles_dir="./$job/${job}_2lev_ref/plotfiles"
    file_count=$(ls -1 "$plotfiles_dir" | wc -l)
    years_complete=$((30*$file_count))

    if [ $years_complete -ge 9990 ]; then
        echo "$job complete!"

    elif grep -q "$job" <<< "$running_jobs"; then
        echo "$job running... $years_complete years done so far"

    else
        echo "$job has not completed but is also not running"
    fi
done
