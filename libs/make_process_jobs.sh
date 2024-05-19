#!/bin/bash

for var in 'calvingFlux' 'calvingRate' 'dragCoef' 'iceFrac' 'sTemp' 'viscosityCoef' 'waterDepth'; do
    sed -e s/@VAR/$var/ $HOME/templates/job.process_var_template.sh > "$CONTROL/process_${var}.sh"
    cd $CONTROL
    qsub "$CONTROL/process_${var}.sh"
done
