#!/bin/bash

for ((i = 63; i <= 88; i++)); do
    jobnum="56467$i"
    qdel $jobnum
done
