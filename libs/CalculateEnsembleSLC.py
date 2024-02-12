# python script to generate a csv with timeseries of sea level contribution for each run

import os
import re
import sys
import pandas as pd
import numpy as np
from pathlib import Path
from summary_to_csv import txt_to_df

def Calculate_SLC(VAF, bBSL, TIV):

    '''
    Calculates sea level contribution from variables provided by GIAstats.
    Follows Goelzer et al. (2020) https://doi.org/10.5194/tc-14-833-2020

    inputs: 
        - VAF: Volume Above Floatation
        - bBSL: bedrock Below Sea Level
        - TIV: Total Ice Volume
    returns: 
        - SLC: Sea level contribution
    '''
    
    A_ocean = 3.625e14  # surface area of the ocean in m^-2 (Gregory et al., 2019)
    rho_ocean = 1028    # density of seawater (kg m^-3)
    rho_ice = 918       # density of ice (kg m^-3)

    SLC_af = -(VAF - VAF[0]) * rho_ice / (rho_ocean * A_ocean)
    SLC_pov = -(bBSL - bBSL[0]) / A_ocean
    SLC_den = -(TIV - TIV[0]) * (rho_ice/1000 - rho_ice/rho_ocean) / A_ocean
    
    SLC = SLC_af + SLC_pov + SLC_den
    
    return SLC

def get_init_state(ensemble):

    '''
    Finds initial values of all GIAstats variables for an ensemble.
    input: 
        - ensemble: pathlib Path object to the ensemble directory
    output: 
        - Pandas dataframe with one row and columns for each GIAstats output var
    '''
    
    relax_stats = sorted(ensemble.glob('run*/run*_2lev_ref/GIAstats_relax'))[0]
    init_stats = sorted(relax_stats.iterdir())[0]

    with open(init_stats, 'r') as file:
        content = file.read()

    df = txt_to_df(content)
    return df

def main(ensemble):

    '''
    Iterates over an ensemble, calculating a time series for sea level contribution 
    in each run and saves them as a csv with columns = runs and rows = time.

    input:
        - ensemble: string path to an ensemble
    returns:
        - None
    '''
    
    path = Path(ensemble)
    init_df = get_init_state(path)
    
    data = {}
    for dir in path.iterdir():
    
        # skip directories that aren't runs
        match = re.search(r'run(\d{3})', dir.name)
        if not match:
            continue
        
        if not dir.is_dir():
            continue
       
        if 'MinRes' in dir.name:
            continue
        
        # open summary_stats.csv if it exists
        run_num = match.group(1)
        csv = dir / f'{dir.name}_2lev_ref' / 'summary_stats.csv'
        try:
            run_df = pd.read_csv(csv)
        except FileNotFoundError:
            continue
        
        # add inital state in at time=0 and extract arrays for Volume Above Floatation,
        # bedrock Beneath Sea Level, and Total Ice Volume
        df = pd.concat([init_df, run_df], ignore_index=True)
        VAF = df['iceVolumeAbove']
        bBSL = df['bedrockBelowSeaLevel']
        TIV = df['iceVolumeAll']
        
        # Calculate sea level contribution
        SLC = Calculate_SLC(VAF, bBSL, TIV)
        data[run_num] = SLC
 
    # sort by run number and save to dataframe
    sorted_data = dict(sorted(data.items()))
    SLC_df = pd.DataFrame(sorted_data)

    # reindex to time coordinates
    #time = np.arange(0, 10_000, 30)
    #SLC_df_with_time = SLC_df.set_index(time)
    
    # save to csv
    csv_path = path / f'{path.name}.csv'
    SLC_df.to_csv(csv_path)
    

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: CalculateEnsembleSLC.py <ensemble_path>')
    else:
        ensemble = sys.argv[1]
        main(ensemble)

