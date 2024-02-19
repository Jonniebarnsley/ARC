import re
import sys
import numpy as np
import pandas as pd
from pathlib import Path

headers = [
    'time', 'iceVolumeAll', 'iceVolumeAbove', 'groundedArea', 'floatingArea', 'totalArea',
    'groundedPlusOpenLandArea', 'iceMassAll', 'iceMassAbove', 'bedrockBelowSeaLevel', 
    'total seawater volume', 'totalWaterVolume', 'totalWaterVolume2', 'bedrockBelowOcean']

def txt_to_df(txt):

    '''
    input: Content of Aggregated GIAstats summary .txt file
    output: dataframe of summary data with variables as headers
    '''

    data = {}
    for var in headers:
        timeseries = re.findall(f'{var} = (-?\d+\.\d+e[+-]\d+)', txt)
        data[var] = list(map(float, timeseries)) 
    df = pd.DataFrame(data)

    # fix issue with duplicate time values
    time = df['time'].drop_duplicates().values
    
    # add time coords on end to replace dropped duplicates
    elements_to_add = len(df['iceVolumeAll']) - len(time)
    if elements_to_add > 0:
        additional_elements = time[-1] + 30 * np.arange(1, elements_to_add+1)
        fixed_time = np.concatenate([time, additional_elements])
        df['time'] = fixed_time
    
    # trim runs that go over 10,000 years because of added time coords
    df = df[df['time']<10_000]

    return df

def main(ensemble):

    '''
    input: path to the ensemble
    
    Iterates over run directories in an ensemble and converts summary_stats.txt files
    into csvs.
    '''
    
    home = Path(ensemble)

    for run in home.iterdir():
        
        # skip directories that aren't runs
        if not re.match(r'run\d{3}', run.name):
            continue
        
        if '.gz' in run.name:
            continue

        summary_file = run / f'{run.name}_2lev_ref' / 'summary_stats.txt'
        
        try:
            with open(summary_file, 'r') as file:
                content = file.read()
        except FileNotFoundError:
            continue

        df = txt_to_df(content)
        csv_path = summary_file.with_suffix('.csv')
        df.to_csv(csv_path)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: python summary_to_csv.py <ensemble_path>')
    else:
        ensemble = sys.argv[1]
        main(ensemble)
