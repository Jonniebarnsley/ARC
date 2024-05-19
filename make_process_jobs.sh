#!/bin/bash

for var in 'calvingFlux' 'calvingRate' 'dragCoef' 'iceFrac' 'sTemp' 'viscosityCoef'; do
    sed -e s/@VAR/$var/ templates/job.process_var_template.sh > "$CONTROL/process_${var}.sh"
done
