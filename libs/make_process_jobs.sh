#!/bin/bash

for var in 'activeBasalThicknessSource' 'activeSurfaceThicknessSource' 'basal_friction' 'basalThicknessSource' 'bTemp' 'calvingFlux' 'calvingRate' 'dragCoef' 'iceFrac' 'sTemp' 'surfaceThicknessSource' 'thickness' 'tillWaterDepth' 'viscosityCoef' 'waterDepth' 'xbVel' 'xVel' 'ybVel' 'yVel' 'Z_base' 'Z_bottom' 'Z_surface'; do
    sed -e s/@VAR/$var/ $HOME/templates/job.process_var_template.sh > "$CONTROL/process_${var}.sh"
    cd $CONTROL
    qsub "$CONTROL/process_${var}.sh"
done
