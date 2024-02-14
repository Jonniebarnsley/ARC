# 01.12.2020
# script for taking PLISMIP climate fields regridded to 768 x 768 ISMIP6 grids, RACMO input data for precip and temperature

# and calculating pdd using pypdd

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

#model = 'control'
path = '../../run_data/'

#plio_temp = xr.open_dataset(glob.glob(path + '{}_Eoi400*temp_768.nc'.format(model))[0])
#cont_temp = xr.open_dataset(glob.glob(path + '{}_E280*temp_768.nc'.format(model))[0])
#plio_precip = xr.open_dataset(glob.glob(path + '{}_Eoi400*precip_768.nc'.format(model))[0])
#cont_precip = xr.open_dataset(glob.glob(path + '{}_E280*precip_768.nc'.format(model))[0])

#control_elev =xr.open_dataset(glob.glob(path + '{}*E280*_orog_768.nc'.format(model))[0])
#plio_elev = xr.open_dataset(glob.glob(path + '{}*Eoi400*_orog_768.nc'.format(model))[0]) 

# read in racmo
RACMO_precip = xr.open_dataset(path + 'RACMO_precip_1979_2000_8000m_precip_768.nc')
RACMO_temp = xr.open_dataset(path + 'RACMO_T2m_1979_2000_8000m_T2m_768.nc')
RACMO_height = xr.open_dataset(path + 'RACMO_T2m_precip_1979_2000_8000m_height_768.nc')

#remove nans from edges
#pliocene_temp = np.asarray(plio_temp.temp)
#plioT2m_nonans =  np.nan_to_num(pliocene_temp, nan=0.0)
#pliocene_precip = np.asarray(plio_precip.precip)
#plioprecip_nonans = np.nan_to_num(pliocene_precip, nan=0.0)

#control_temp = np.asarray(cont_temp.temp)
#controlT2m_nonans = np.nan_to_num(control_temp, nan=0.0)
#control_precip = np.asarray(cont_precip.precip)
#controlprecip_nonans = np.nan_to_num(control_precip, nan=np.nanmax(control_precip))

RACMO_temp = np.asarray(RACMO_temp.T2m)
RACMOT2m_nonans =  np.nan_to_num(RACMO_temp, nan=0.0)
RACMO_precip = np.asarray(RACMO_precip.precip)
RACMOprecip_nonans = np.nan_to_num(RACMO_precip, nan=0.0)

# convert to degrees C before applying elevation correction
#pliotemp_uncorrected = plioT2m_nonans #- 273.15 # in celsius so comment out
#controltemp_uncorrected = controlT2m_nonans #- 273.15
RACMOtemp_uncorrected = RACMOT2m_nonans - 273.15

# convert precip to m/yr
#plioprecip = plioprecip_nonans /1000 * 365
#controlprecip = controlprecip_nonans /1000 * 365 
# convert RACMO from kgm^-2yr^-1 to myr-1
RACMOprecip = RACMOprecip_nonans / 1000 * 12

if len(dir) != 0:
    print(len(dir))
    plotfile = dir[-1]
    print(plotfile)
    amrID = amrio.load(plotfile)
    level = 0
    lo, hi = amrio.queryDomainCorners(amrID, level)
    order = 0

    # now get relevant variables thickness and surface
    zsurfcomp = "Z_surface"
    x0, y0, zsurface0 = amrio.readBox2D(amrID, level, lo, hi, zsurfcomp, order)

    # read in thickness for basal melt
    thkcomp = "thickness"
    x0, y0, thk0 = amrio.readBox2D(amrID, level, lo, hi, thkcomp, order)

 #   plioGCM_elevation = np.nan_to_num(plio_elev.orog)

 #   controlGCM_elevation = np.nan_to_num(control_elev.orog)

    RACMOGCM_elevation = np.nan_to_num(RACMO_height.height)

    # include lines to downsample  temperature and precipitation to resolution of plotfile
    import skimage
    from skimage.measure import block_reduce
    plotfile_res = x0[1] - x0[0]
    print('plotfile res ' + str(plotfile_res))
    RacT = xr.open_dataset(path + 'RACMO_T2m_1979_2000_8000m_T2m_768.nc')
    climate_res = RacT.x[1].data - RacT.x[0].data
  #  climate_res = RACMO_temp.x[1] - RACMO_temp.x[0]
    print('climate res ' + str(climate_res))
    if plotfile_res != climate_res:
        dsi = int(plotfile_res / climate_res)
  #      pliotemp_uncorrected = block_reduce(pliotemp_uncorrected, block_size=(1, dsi, dsi), func=np.mean, cval=np.max(pliotemp_uncorrected))
  #      controltemp_uncorrected = block_reduce(controltemp_uncorrected, block_size=(1, dsi, dsi), func=np.mean, cval=np.max(controltemp_uncorrected))       
        RACMOtemp_uncorrected = block_reduce(RACMOtemp_uncorrected, block_size=(1, dsi, dsi), func=np.mean, cval=np.max(RACMOtemp_uncorrected))
  #      plioprecip = block_reduce(plioprecip, block_size=(1, dsi, dsi), func=np.mean, cval=np.min(plioprecip))
  #      controlprecip = block_reduce(controlprecip, block_size=(1, dsi, dsi), func=np.mean, cval=np.min(controlprecip)) 
        RACMOprecip = block_reduce(RACMOprecip, block_size=(1, dsi, dsi), func=np.mean, cval=np.min(RACMOprecip))
  #      plioGCM_elevation = block_reduce(plioGCM_elevation, block_size=(dsi, dsi), func=np.mean, cval=np.min(plioGCM_elevation))
  #      controlGCM_elevation = block_reduce(controlGCM_elevation, block_size=(dsi, dsi), func=np.mean, cval=np.min(controlGCM_elevation))
        RACMOGCM_elevation = block_reduce(RACMOGCM_elevation, block_size=(dsi, dsi), func=np.mean, cval=np.min(RACMOGCM_elevation))

    # read in ice sheet elevation
    ISM_elevation = zsurface0
    print('ISM elevation mean ' + str(np.mean(ISM_elevation)))
    # calculate the temperature correction (use constant lapse rate for now, as in Dolan 2018)
    lapse_rate = - 0.007
    print('ISM shape ' + str(ISM_elevation.shape))
    # compute corrections for each of the elevations
  #  pliocorrection = lapse_rate * (ISM_elevation - plioGCM_elevation.data)
  #  controlcorrection = lapse_rate * (ISM_elevation - controlGCM_elevation.data)
    RACMOcorrection = lapse_rate * (ISM_elevation - RACMOGCM_elevation.data)
  #  print('plio correction mean ' + str(np.mean(pliocorrection)))
    # generate 12 x a x a correction array to minus from original temp to correct
    b = len(x0)
    a = len(y0)
  #  plio_correction_array = np.empty((12, a, b))
  #  control_correction_array = np.empty((12, a, b))
    RACMO_correction_array = np.empty((12, a, b))
    for i in range(12):
  #      plio_correction_array[i, :, :] = pliocorrection
  #      control_correction_array[i, :, :] = controlcorrection
        RACMO_correction_array[i, :, :] = RACMOcorrection
    # apply correction so that pdd model uses elevation corrected temp
 #   pliotemp = pliotemp_uncorrected + plio_correction_array
 #   controltemp = controltemp_uncorrected + control_correction_array
    RACMOtemp = RACMOtemp_uncorrected + RACMO_correction_array

    temp = RACMOtemp #+ pliotemp - controltemp

    # elevation correction for atmosphere
    alpha = 0.05
    import math

    elevation_correction = ISM_elevation - RACMOGCM_elevation.data # - plioGCM_elevation.data + controlGCM_elevation.data

    ISM_elevation = ISM_elevation
    RACMOGACM_elevation = RACMOGCM_elevation
#    plioGCM_elevation = plioGCM_elevation
#    controlGCM_elevation = controlGCM_elevation
#    print(np.max(controlGCM_elevation))
#    print(np.max(plioGCM_elevation))
    print(np.max(RACMOGCM_elevation))
    print(np.max(ISM_elevation))
#    print('control precip: ' + str(np.unique(np.isnan(controlprecip))))
    print('racmo precip: ' + str(np.unique(np.isnan(RACMOprecip))))
#    print('plioprecip: ' + str(np.unique(np.isnan(plioprecip))))
    print('ism elev: ' + str(np.unique(np.isnan(ISM_elevation))))
    print('racmo elev: ' + str(np.unique(np.isnan(RACMOGACM_elevation))))
#    print('plio elev: ' + str(np.unique(np.isnan(plioGCM_elevation))))
#    print('control elev: ' + str(np.unique(np.isnan(controlGCM_elevation))))

    LRP= -0.0004    

    basePrecip = RACMOprecip * np.exp (LRP * (ISM_elevation - RACMOGCM_elevation))
    print('base precip shape: ' + str(basePrecip.shape))
    print('base precip max = ' +  str(np.max(basePrecip)))
#    plioPrecip = plioprecip * np.exp(LRP * (ISM_elevation - plioGCM_elevation))
#    print('plio precip shape: ' + str(plioPrecip.shape))
#    print('pliop precip max = ' + str(np.max(plioPrecip)))
#    controlPrecip = controlprecip * np.exp(LRP * (ISM_elevation - controlGCM_elevation))
    #test = np.where(controlprecip == 0.0, 1, np.zeros_like(controlprecip))
#    print('control precip shape: ' + str(controlPrecip.shape))
#    print('control precip max = ' + str(np.max(controlPrecip)))
#    Scaling = plioPrecip / controlPrecip
    PplioRatio_EC = basePrecip  #* Scaling
    # generate precipitation without elevation correction
    # now for the PDD
    pdds = 0.004
    pddi = 0.014
    pdd = PDDModel(pdd_factor_snow = pdds, pdd_factor_ice = pddi)
    pdd_results_PplioRatioEC = pdd(temp, PplioRatio_EC)
    PplioRatioEC_smb = pdd_results_PplioRatioEC['smb']
    # now need to make a netcdf for smb, use the most recent plot file as a template for coords etc
    # want to set smb to zero anywhere outside ASE
    print('pdd script run...')
    # below are wrong way round, need to figure out at some poimt, same withj a = ... and b = ...
    Y = x0
    X = y0
    smb = PplioRatioEC_smb #* PIGmask
    ds = xr.Dataset({'smb': (('x', 'y'), smb)},
                    coords={'x': X,
                            'y': Y})
    ds.to_netcdf('smb.nc', 'w')
else:
    print('error...')
# Python 3:
print('run time = ' + str(datetime.now() - startTime))
