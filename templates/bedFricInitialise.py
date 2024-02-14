#!/bin/bash
#script to calculate initial bed friction

# import statements
import xarray as xr
import numpy as np
import scipy
from scipy.ndimage import zoom, gaussian_filter
from datetime import datetime
import glob
startTime = datetime.now()

# read in initial bed elevation
zbase0 = xr.open_dataset('../../ant-minbed64-RaisedEdges-032021.nc').topg #../data/ase_bedmachine_geometry_500m.2d.nc').topg[::2, ::2] #read in at half resolution
# based on modern inverted
cmin = 7000.
# based on average of modern inverted
cmax = 34000. #59167.21763599102
# based on best performing from mini ensemble
z0 = -2200.

def BlascoCthird(topg, z0, cmin, cmax, fricName, dsTemplate): #, domain, dsTemplate):
    cb = np.empty_like(topg)
    cmax = cmax
    z0 = z0
    cmin = np.zeros_like(topg) + cmin
    zb = topg
    print(zb.shape)
    cb = np.where(zb >= 0, cmax, cb)
    foldingcmax = (cmax * np.exp(-zb / z0))
    cb = np.where(zb < 0, np.maximum(foldingcmax, cmin), cb)
    #if domain=='ASE':
    #    cb[1900:, 700:1200] = 34000
    # add masking
    #mask=xr.open_dataset('../../data/masks/ase_bedmachine_basin_500m.2d.nc')
    #mask = mask.ase #[::2,::2]
    #mask[1500:1812, 500:1250]=1 # <- add more mask to see if it helps
    #print(mask.shape)
    #cb = scipy.ndimage.zoom(cb, 2)
    #cb = np.where(mask>0, cb, np.ones_like(cb)*1e8)
    copy_dset = dsTemplate.copy()
    copy_dset[fricName][:]=cb
    saveName = 'Cthird_elev_coupled.nc'
    copy_dset.to_netcdf(saveName)

dsTemplate=glob.glob('Cthird_template.nc')[0]
dsTemplate = xr.open_dataset(dsTemplate)
topg = zbase0
#maskfile = xr.open_dataset('').ase

BlascoCthird(topg, z0, cmin, cmax, 'Cthird', dsTemplate)
