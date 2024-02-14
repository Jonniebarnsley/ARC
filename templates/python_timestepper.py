#
# import statements
import xarray as xr
import numpy as np
import glob
from datetime import datetime
startTime = datetime.now()

# use amrio to read bisicles plotfile
import sys

genpath = '/nobackup/earjo/python_modules'
sys.path.append(genpath)
from amrfile import io as amrio

dir=sorted(glob.glob('plotfiles/plot.*hdf5'))
lastplot=amrio.load(dir[-1])
lastPlotTime=amrio.queryTime(lastplot)
lastPlotTime = int(lastPlotTime/30)*30
print('mostRecentPlotTime=' + str(int(lastPlotTime)))
amrio.freeAll()
