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


# read in reformatted PLISMIP data
import glob, os

dir = sorted(glob.glob('plotfiles/plot*.hdf5'))

#model = 'control'
path = '../../run_data/'

#plio_temp = xr.open_dataset(glob.glob(path + '{}_Eoi400*_8000m_temp_768.nc'.format(model))[0])
#cont_temp = xr.open_dataset(glob.glob(path + '{}_E280*_8000m_temp_768.nc'.format(model))[0])
#plio_precip = xr.open_dataset(glob.glob(path + '{}_Eoi400*_8000m_precip_768.nc'.format(model))[0])
#cont_precip = xr.open_dataset(glob.glob(path + '{}_E280*_8000m_precip_768.nc'.format(model))[0])

#control_elev =xr.open_dataset(glob.glob(path + '{}*E280*_orog_768.nc'.format(model))[0])
#plio_elev = xr.open_dataset(glob.glob(path + '{}*Eoi400*_orog_768.nc'.format(model))[0]) 

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

## generate init SMB corrected to RACMO height

#plioGCM_elevation = np.nan_to_num(plio_elev.orog)
#controlGCM_elevation = np.nan_to_num(control_elev.orog)
RACMOGCM_elevation = np.nan_to_num(RACMO_height.height)

# correct to RACMOGCM_elevation in place of ISM for init
ISM_elevation = RACMOGCM_elevation

lapse_rate = - 0.007
#pliocorrection = lapse_rate * (ISM_elevation - plioGCM_elevation.data)
#controlcorrection = lapse_rate * (ISM_elevation - controlGCM_elevation.data)
RACMOcorrection = lapse_rate * (ISM_elevation - RACMOGCM_elevation.data)
a = 768
b = 768
#plio_correction_array = np.empty((12, a, b))
#control_correction_array = np.empty((12, a, b))
RACMO_correction_array = np.empty((12, a, b))
for i in range(12):
#    plio_correction_array[i, :, :] = pliocorrection
#    control_correction_array[i, :, :] = controlcorrection
    RACMO_correction_array[i, :, :] = RACMOcorrection

#pliotemp = pliotemp_uncorrected + plio_correction_array
#controltemp = controltemp_uncorrected + control_correction_array
RACMOtemp = RACMOtemp_uncorrected + RACMO_correction_array

temp = RACMOtemp #+ pliotemp - controltemp

# elevation correction for atmosphere
LRP = - 0.0004

basePrecip = RACMOprecip * np.exp (LRP * (ISM_elevation - RACMOGCM_elevation))
print('base precip shape: ' + str(basePrecip.shape))
print('base precip max = ' +  str(np.max(basePrecip)))
#plioPrecip = plioprecip * np.exp(LRP * (ISM_elevation - plioGCM_elevation))
#print('plio precip shape: ' + str(plioPrecip.shape))
#print('pliop precip max = ' + str(np.max(plioPrecip)))
#controlPrecip = controlprecip * np.exp(LRP * (ISM_elevation - controlGCM_elevation))
#test = np.where(controlprecip == 0.0, 1, np.zeros_like(controlprecip))
#print('control precip shape: ' + str(controlPrecip.shape))
#print('control precip max = ' + str(np.max(controlPrecip)))
#Scaling = plioPrecip / controlPrecip
PplioRatio_EC = basePrecip #* Scaling
# generate precipitation without elevation correction
# now for the PDD
pdds = 0.004
pddi = 0.014
pdd = PDDModel(pdd_factor_snow = pdds, pdd_factor_ice = pddi)
pdd_results_PplioRatioEC = pdd(temp, PplioRatio_EC)
PplioRatioEC_smb = pdd_results_PplioRatioEC['smb']

smb = PplioRatioEC_smb 
ds = xr.Dataset({'smb': (('x', 'y'), smb)},
                coords={'x': np.arange(4.0e+3,6144.0e+3,8.0e+3) - 6144.0e+3*0.5,
                        'y': np.arange(4.0e+3,6144.0e+3,8.0e+3) - 6144.0e+3*0.5})
ds.to_netcdf('smb.nc', 'w')

