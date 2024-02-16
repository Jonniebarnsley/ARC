# script for calculating the initial smb using RACMO and pyPDD

import numpy as np
import xarray as xr
from pathlib import Path
from pypdd import PDDModel

cwd = Path.cwd()
forcings = cwd.parent / 'forcing_data'

# read in forcing data
NCs = [
    'RACMO_T2m_1979_2000_8000m_T2m_768.nc',
    'RACMO_precip_1979_2000_8000m_precip_768.nc'
]
vars = ['T2m', 'precip']

data = {}
for var, nc in zip(vars, NCs):
    ds = xr.open_dataset(forcings / nc)
    array = np.asarray(ds[var])
    nonan = np.nan_to_num(array)
    data[var] = nonan

temp = data['T2m'] - 273.15 # Kelvin to Celsius
precip = data['precip'] / 1000 * 12 # kgm^-2yr^-1 to myr^-1

# run PDD model
pdds = 0.004 # positive degree day factor snow
pddi = @PDDi # positive degree day factor ice
pdd = PDDModel(pdd_factor_snow = pdds, pdd_factor_ice = pddi)
pdd_results = pdd(temp, precip)
smb = pdd_results['smb']
 
ds = xr.Dataset({'smb': (('x', 'y'), smb)},
                coords={'x': np.arange(4.0e+3,6144.0e+3,8.0e+3) - 6144.0e+3*0.5,
                        'y': np.arange(4.0e+3,6144.0e+3,8.0e+3) - 6144.0e+3*0.5})
ds.to_netcdf('smb.nc', 'w')