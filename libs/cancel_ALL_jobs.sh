#!/bin/bash

running_job_ids=$(bash $HOME/libs/qstatFullJobNames.sh | awk '{print $1}')

for id in $running_job_ids; do
    qdel $id
done
