# script to calculate bed friction

# import statements
import xarray as xr
import numpy as np
from pypdd import PDDModel
import scipy
from scipy.ndimage import zoom, gaussian_filter

from datetime import datetime

startTime = datetime.now()

# use amrio to read bisicles plotfile
import sys

genpath = '/nobackup/earjo/python_modules'
sys.path.append(genpath)
from amrfile import io as amrio

# read in reformatted PLISMIP data
import glob, os

dir = sorted(glob.glob('plotfiles/plot*.hdf5'))

plotfile = dir[-1]
print(plotfile)
amrID = amrio.load(plotfile)
level = 0
lo, hi = amrio.queryDomainCorners(amrID, level)
order = 0

# now get relevant variables thickness and surface
zbase = "Z_base"
x0, y0, zbase0 = amrio.readBox2D(amrID, level, lo, hi, zbase, order)

# based on modern inverted
cmin = 7000.
# based on average of modern inverted
cmax = @WeertC
# based on best performing from mini ensemble
z0 = -2000.

def BlascoCthird(topg, z0, cmin, cmax, fricName, dsTemplate): #, domain, dsTemplate):
    cb = np.empty_like(topg)
    cmax = cmax
    z0 = z0
    cmin = np.zeros_like(topg) + cmin
    zb = topg
    cb = np.where(zb >= 0, cmax, cb)
    foldingcmax = (cmax * np.exp(-zb / z0))
    cb = np.where(zb < 0, np.maximum(foldingcmax, cmin), cb)
    #if domain=='ASE':
    #    cb[1900:, 700:1200] = 34000
    copy_dset = dsTemplate.copy()
    copy_dset[fricName][:]=cb
    saveName = 'Cthird_elev_coupled.nc'
    copy_dset.to_netcdf(saveName)

dsTemplate=glob.glob('Cthird_template.nc')[0]
dsTemplate = xr.open_dataset(dsTemplate)
topg = scipy.ndimage.zoom(zbase0, 16)
BlascoCthird(topg, z0, cmin, cmax, 'Cthird', dsTemplate) 


