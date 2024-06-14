#!/bin/bash

for i in {06..26}; do
    jobnum="60918$i"
    qdel $jobnum
done
