#!/bin/env python
# script to extract data from hdf5 plotfiles

#import statements
import xarray as xr
import numpy as np
from pypdd import PDDModel
import scipy
from scipy.ndimage import zoom
import glob
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from mpl_toolkits.axes_grid1.anchored_artists import AnchoredSizeBar
import matplotlib.font_manager as fm
import glob
import os
from matplotlib.colors import LogNorm
#use amrio to read bisicles plotfile
import sys
genpath='/nobackup/earjo/python_modules'
sys.path.append(genpath)
from amrfile import io as amrio
savedir='outPutNC_jan2024'
if os.path.exists(savedir):
    print(f'{savedir} exists...')
else:
    os.mkdir(savedir)
variablenames = ['basalThicknessSource', 'surfaceThicknessSource', 'Z_surface', 'thickness', 'tillWaterDepth', 'dragCoef', 'mask']
variablesnames = ['Z_base']
def extractField(variablename, plotfile, lev):
    """
    Function to generate an nc file with variables stored in layers
    corresponding to plot year
    :param variablename: (str)
    :param plotfile: name of plotfile (str)
    :return:
    """

    amrID = amrio.load(plotfile)
#    if variablename == 'Z_base':
#        level=0
#    else:
#        level = 2
    level=lev
    lo, hi = amrio.queryDomainCorners(amrID, level)
    order = 0
    x0, y0, variable = amrio.readBox2D(amrID, level, lo, hi, variablename, order)
    amrio.freeAll()
    return variable

# do straight forward variables
def generateVariableNC(variable, run, lev):
    savedir='outPutNC_jan2024'
    savedir=savedir + '/{}'.format(variable)
    if os.path.exists(savedir):
        print(savedir + 'exists...')
    else:
        os.mkdir(savedir)
    if os.path.exists(savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev)):
        print(savedir + '/{}_{}_{}lev.nc exists...'.format(run, variable.replace("/",""), lev))
    else:
        #dir0 = sorted(glob.glob('{}*/*2lev*/plotfiles_4kyr/plot*.hdf5'.format(run)))
        #dir1 = sorted(glob.glob('{}*/*2lev*/plotfiles/plot*.hdf5'.format(run)))[:210][1:]
        #dir2 = dir0 + dir1
        # get last time from previous 4kyr run
        #amrID = amrio.load(dir0[-1])
        #PrevLastTime = amrio.queryTime(amrID)
        #amrio.freeAll()
        print('processing {} ...'.format(run))
        dir= sorted(glob.glob('{}/{}_2lev_ref/plotfiles/plot*.hdf5'.format(run, run)))
        amrID = amrio.load(dir[0])
#        if variable == 'Z_base':
#            level=0
#        else:
#            level = 2
        level=lev
        lo, hi = amrio.queryDomainCorners(amrID, level)
        order = 0
        zsurfcomp = "Z_surface"
        x0, y0, zsurface0 = amrio.readBox2D(amrID, level, lo, hi, zsurfcomp, order)
        amrio.freeAll()
        cube=np.empty((len(dir), len(y0), len(x0)))
        times = []
        for i in range(len(dir)):
            print(i)
            plotfile=dir[i]
            layer=extractField(variable, plotfile, lev)
            amrID = amrio.load(plotfile)
            time = amrio.queryTime(amrID)
            cube[i, :, :] = layer
            times.append(int(time))
           # if 'plotfiles_4kyr' in plotfile:
           #     times.append(int(time))
           # else:
           #     times.append(int(time + PrevLastTime))
            #times.append(time)
            amrio.freeAll()
        #run_descriptor = dir[0][5:-20]
        
        # correct issue of repeating 30s in some runs
        if times[0] == times[1] == 30:
            times = [30]+[t+30 for t in times[1:]]

        # correct issue in run 083
        if times[273] == times[274] == 8190:
            times = times[:274]+[t+30 for t in times[274:]]
        
        times = np.asarray(times)
        variable_spec={'thickness':{'conversion':1.0, 'prec':0.01,'dtype':'int32','units':'m'},
                       'Z_surface':{'conversion':1.0, 'prec':0.01,'dtype':'int32','units':'m'},
                       'Z_base':{'conversion':1.0, 'prec':0.01,'dtype':'int32','units':'m'},
                       'Z_bottom':{'conversion':1.0, 'prec':0.01,'dtype':'int32','units':'m'},
                       'basal_friction':{'conversion':1.0, 'prec':1.0,'dtype':'int32','units':''},
                       'surfaceThicknessSource':{'conversion':1000.0, 'prec':1.0,'dtype':'int32','units':'mm/yr'},
                       'activeSurfaceThicknessSource':{'conversion':1000.0, 'prec':1.0,'dtype':'int32','units':'mm/yr'},
                       'basalThicknessSource':{'conversion':1000.0, 'prec':1.0,'dtype':'int32','units':'mm/yr'},
                       'activeBasalThicknessSource':{'conversion':1000.0, 'prec':1.0,'dtype':'int32','units':'mm/yr'},
                       'tillWaterDepth':{'conversion':1000.0, 'prec':1.0,'dtype':'int32','units':'mm'},
                       'waterDepth':{'conversion':1000.0, 'prec':1.0,'dtype':'int32','units':'mm'},
                       'mask':{'conversion':1.0, 'prec':1.0,'dtype':'int16','units':'unitless'}, 
                       'yVel':{'conversion':1.0, 'prec':0.01,'dtype':'int32','units':'m/yr'},
                       'xVel':{'conversion':1.0, 'prec':0.01,'dtype':'int32','units':'m/yr'},
                       'ybVel':{'conversion':1.0, 'prec':0.01,'dtype':'int32','units':'m/yr'},
                       'xbVel':{'conversion':1.0, 'prec':0.01,'dtype':'int32','units':'m/yr'}} #,
        cube=cube*variable_spec[variable]['conversion']
       ## if variable in ['thickness']:
       ##     cube=np.where(cube==0, np.nan, cube)   #*1000
       ## else:
       ##     cube=cube
        ds = xr.Dataset({str(variable): (('t', 'x', 'y'), cube)},
                        coords={'t': times,
                                'x': y0,
                                'y': x0})
        variable = variable.replace(' ', '')
        print(variable)
        precision=variable_spec[variable]['prec']  #0.01
        dtype=variable_spec[variable]['dtype'] #'int32'
        comp_level=6
        comp = dict(zlib=True, complevel=comp_level)
        encoding = {var: comp for var in ds.data_vars}
        ds.attrs['units']=variable_spec[variable]['units']
        #ds.attrs['description']='saved as mm, x1000 for m'
        ds[variable].encoding.update({'zlib':True})
        ds = ds.sel(t=slice(None, 9990))        
        ds.to_netcdf(
                savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev), 
                encoding={variable: {
                    'zlib':True, 
                    'complevel':comp_level, 
                    'dtype': dtype, 
                    'scale_factor': precision, 
                    '_FillValue': 0
                    }})
"""    
    if variable == 'mask':
            comp = dict(zlib=True, complevel=9)
            encoding = {var: comp for var in ds.data_vars}
            ds.mask.encoding.update({'zlib':True})
            #ds.to_netcdf('outPutNCs_V2/{}_{}_post4k.nc'.format(run, variable.replace("/",""), encoding=encoding, engine='netcdf4'))
            ds.to_netcdf(savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev),encoding={'mask': {'zlib': True}}, engine='netcdf4')
        elif variable in ['thickness']:
            precision=0.01
            dtype='int32'
            comp = dict(zlib=True, complevel=9)
            encoding = {var: comp for var in ds.data_vars}
            ds[variable]=ds[variable]
            ds.attrs['units']='mm'
            ds.attrs['description']='saved as mm, x1000 for m'
            ds[variable].encoding.update({'zlib':True})
            #ds.to_netcdf(savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev),encoding={variable.replace("/",""): {'zlib': True}}, engine='netcdf4')
            ds.to_netcdf(savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev), encoding={variable: {'zlib':True, 'complevel':9, 'dtype': dtype, 'scale_factor': precision}})#, '_FillValue': -9999}})
        elif variable in ['Z_surface', 'Z_base','Z_bottom', 'basal_friction']:
            precision=0.01
            dtype='int32'
            comp = dict(zlib=True, complevel=9)
            encoding = {var: comp for var in ds.data_vars}
            ds[variable].encoding.update({'zlib':True})
            #ds.to_netcdf(savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev),encoding={variable.replace("/",""): {'zlib': True}}, engine='netcdf4')
            ds.to_netcdf(savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev), encoding={variable: {'zlib':True, 'complevel':9, 'dtype': dtype, 'scale_factor': precision, '_FillValue': -9999}})
            #ds.to_netcdf(savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev), encoding={variable: {'zlib':True, 'complevel':9, 'dtype': dtype}}) #, 'scale_factor': precision}})
        elif variable in ['surfaceThicknessSource', 'basalThicknessSource', 'tillWaterDepth']:
            precision=0.01
            dtype='int32'
            ds.to_netcdf(savedir + '/{}_{}_{}lev.nc'.format(run, variable.replace("/",""), lev), encoding={variable: {'zlib':True, 'complevel':9, 'dtype': dtype, 'scale_factor': precision, '_FillValue': -9999}})
    #else:
    #    print('{} error ignore...'.format(run))
"""
"""
def generateSpeedNC(run):
    if os.path.exists('outPutNCs_V2/{}_{}_post4k.nc'.format(run, 'speed')):
        print('outPutNCs_V2/{}_{}_post4k.nc exists...'.format(run, 'speed'))
    elif len(glob.glob('{}/{}_2lev_ref/plotfiles/plot.*.hdf5'.format(run, run)))>=203:
        dir = sorted(glob.glob('{}*/*2lev*/plotfiles/plot*.hdf5'.format(run)))[:203]
        # get last time from previous 4kyr run
        dir4k = xr.open_dataset('outPutNCs_V2/{}_{}.nc'.format(run, variable.replace("/","")))
        PrevLastTime = dir4k.t[-1].data
        print('processing {} ...'.format(run))
        amrID = amrio.load(dir[0])
        level = 2
        lo, hi = amrio.queryDomainCorners(amrID, level)
        order = 0
        zsurfcomp = "Z_surface"
        x0, y0, zsurface0 = amrio.readBox2D(amrID, level, lo, hi, zsurfcomp, order)
        amrio.freeAll()
        speeds=np.empty((len(dir), len(y0), len(x0)))
        times = []
        for i in np.arange(len(dir)):
            plotfile = dir[i]
            amrID = amrio.load(plotfile)
            level = 2
            lo, hi = amrio.queryDomainCorners(amrID, level)
            order = 0
            #read in velocty
            xVel = "xVel"
            yVel = "yVel"
            x0, y0, xVel = amrio.readBox2D(amrID, level, lo, hi, xVel, order)
            x0, y0, yVel = amrio.readBox2D(amrID, level, lo, hi, yVel, order)
            speed = np.sqrt(xVel**2+yVel**2)
            time = amrio.queryTime(amrID)
            amrio.freeAll()
            speeds[i, :, :] = speed
            times.append(time)
        times = np.asarray(times) + PrevLastTime
        ds = xr.Dataset({'speed': (('t', 'x', 'y'), speeds)},
                    coords={'t': times,
                            'x': y0,
                            'y': x0})
        ds.to_netcdf(
                'outPutNCs_V2/{}_{}_post4k.nc'.format(run, 'speed'), 
                encoding={'speed': {
                    'zlib':True, 
                    'complevel':9, 
                    'dtype': 'int32', 
                    'scale_factor': 0.1, 
                    '_FillValue': 0
                    }})
    else:
        print('{} hasnt run 5kyr yet, ignore...'.format(run))
"""
if __name__== "__main__":
    run=sys.argv[1]
    #variables = ['thickness']#, 'Z_base', 'Z_bottom', 'dragCoef', 'xVel', 'yVel', 'basal_friction', 'tillWaterDepth'] #['mask', 'surfaceThicknessSource','basalThicknessSource'] #'Z_surface', 'basalThicknessSource', 'surfaceThicknessSource', 'Z_surface', 'thickness', 'tillWaterDepth', 'dragCoef', 'mask'] #'mask','thickness', 'Z_base', 'mask'] #,'Z_bottom', 'basal_friction', 'activeSurfaceThicknessSource', 'activeBasalThicknessSource'] #, 'heatfluxBase','tillWaterDepth','iceFrac', 'dThickness/dt', 'xbVel', 'ybVel', 'bT','sTemp']
    variable=str(sys.argv[2])
    lev=0
    generateVariableNC(variable, run, lev)
   # for variable in variables:
   #     print(variable)
   #     generateVariableNC(variable, run, lev)
   # generateSpeedNC(run)
                           
