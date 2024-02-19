#!/bin/env python
# script to extract data from hdf5 plotfiles

import sys
import numpy as np
import xarray as xr
from pathlib import Path

# import amrio from bisicles
genpath='/nobackup/earjo/python_modules'
sys.path.append(genpath)
from amrfile import io as amrio

MAX_TIME = 10_000   # trim time axis at this value
FILL_VALUE = 0      # fill NaNs with this value

# specs for encoding
specs={
    'thickness'                     :   {'conversion':1.0, 'prec':0.01, 'dtype':'int32', 'units':'m'},
    'Z_surface'                     :   {'conversion':1.0, 'prec':0.01, 'dtype':'int32', 'units':'m'},
    'Z_base'                        :   {'conversion':1.0, 'prec':0.01, 'dtype':'int32', 'units':'m'},
    'Z_bottom'                      :   {'conversion':1.0, 'prec':0.01, 'dtype':'int32', 'units':'m'},
    'basal_friction'                :   {'conversion':1.0, 'prec':1.0, 'dtype':'int32', 'units':''},
    'surfaceThicknessSource'        :   {'conversion':1000.0, 'prec':1.0, 'dtype':'int32', 'units':'mm/yr'},
    'activeSurfaceThicknessSource'  :   {'conversion':1000.0, 'prec':1.0, 'dtype':'int32', 'units':'mm/yr'},
    'basalThicknessSource'          :   {'conversion':1000.0, 'prec':1.0, 'dtype':'int32', 'units':'mm/yr'},
    'activeBasalThicknessSource'    :   {'conversion':1000.0, 'prec':1.0, 'dtype':'int32', 'units':'mm/yr'},
    'tillWaterDepth'                :   {'conversion':1000.0, 'prec':1.0, 'dtype':'int32', 'units':'mm'},
    'waterDepth'                    :   {'conversion':1000.0, 'prec':1.0, 'dtype':'int32', 'units':'mm'},
    'mask'                          :   {'conversion':1.0, 'prec':1.0, 'dtype':'int16', 'units':'unitless'}, 
    'yVel'                          :   {'conversion':1.0, 'prec':0.01, 'dtype':'int32', 'units':'m/yr'},
    'xVel'                          :   {'conversion':1.0, 'prec':0.01, 'dtype':'int32', 'units':'m/yr'},
    'ybVel'                         :   {'conversion':1.0, 'prec':0.01, 'dtype':'int32', 'units':'m/yr'},
    'xbVel'                         :   {'conversion':1.0, 'prec':0.01, 'dtype':'int32', 'units':'m/yr'}
    }

def extract_field(variable, plotfile, lev=0, order=0):

    '''
    Extracts time and variable data from a .hdf5 plotfile and returns an xarray dataset

    :param variable: (str)
    :param plotfile: name of plotfile (str)

    :return time: time of plotfile (int)
    :return ds: dataset of variable (xr.DataSet)
    '''

    # read hdf5
    amrID = amrio.load(plotfile)
    time = amrio.queryTime(amrID)
    lo, hi = amrio.queryDomainCorners(amrID, lev)
    x0, y0, field = amrio.readBox2D(amrID, lev, lo, hi, variable, order)

    # convert into correct units
    conversion_factor = specs[variable]['conversion']
    field_in_units = np.asarray(field) * conversion_factor

    # make DataSet
    ds = xr.Dataset({
        variable: xr.DataArray(
            data = field_in_units,
            dims = ['x', 'y'],
            coords = {'x': x0, 'y': y0},
            attrs = {'units': specs[variable]['units']}
        )})
    amrio.freeAll()

    return time, ds

def generate_netcdf(variable, run, lev=0):

    '''
    Iterates over all plotfiles in a run directory and generates a netcdf for that run and variable

    :param variable:    variable name (str)
    :param run:         run directory name (str)
    :param lev:         level (int)
    '''

    # prepare directory
    run_directory = Path(run)
    ensemble = run_directory.parent
    savedir = ensemble / 'netcdfs' / variable
    savedir.mkdir(parents=True, exists_ok=True)

    # skip if file already exists
    filepath = savedir / f'{ensemble.name}_{run_directory.name}_{variable}_{lev}lev.nc'
    if filepath.is_file():
        return

    times = []
    timeslices = []
    plotfiles = run_directory / f'{run_directory.name}_2lev_ref' / 'plotfiles'
    for plotfile in sorted(plotfiles.iterdir()):

        # get datasets from plotfiles and associated time coordinates
        time, timeslice = extract_field(variable, plotfile, lev=lev)
        times.append(time)
        timeslices.append(timeslice)

    # correct issue of repeating 30s in some runs
    if times[0] == times[1] == 30:
        times = [30]+[t+30 for t in times[1:]]

    # correct issue in run 083
    if times[273] == times[274] == 8190:
        times = times[:274]+[t+30 for t in times[274:]]

    # concatenate along the time axis
    concatenated = xr.concat(timeslices, dim='time')
    ds = concatenated.assign_coords(time=times)
    ds = ds.sel(time=slice(0, MAX_TIME)) # trim off any leftover after time adjustments

    # get enconding info
    precision = specs[variable]['prec']
    dtype = specs[variable]['dtype']
    ds[variable].encoding.update({'zlib': True})
    
    # save netcdf
    ds.to_netcdf(filepath, encoding={variable: {
        'zlib'          : True, 
        'complevel'     : 6, 
        'dtype'         : dtype,
        'scale_factor'  : precision, 
        '_FillValue'    : FILL_VALUE
        }})

if __name__== '__main__':
    if len(sys.argv) != 3:
        print('Usage: python generate_run_NCs.py <run_directory> <variable>')
    else:
        run = sys.argv[1]
        variable = sys.argv[2]
        generate_netcdf(variable, run)

                           