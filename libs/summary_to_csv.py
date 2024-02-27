#!/bin/env python

'''
Script for converting summary.txt files (containing GIAstats summary data for a single ensemble
member) into a summary.csv file.

Usage: python summary_to_csv.py <path/to/summary.txt>
'''

import re
import sys
import numpy as np
from pandas import DataFrame
from pathlib import Path

def txt_to_df(txt: str) -> DataFrame:

    '''
    input: Content of Aggregated GIAstats summary.txt file
    returns: dataframe of summary data with variables as headers
    '''

    headers = [
    'time', 'iceVolumeAll', 'iceVolumeAbove', 'groundedArea', 'floatingArea', 'totalArea',
    'groundedPlusOpenLandArea', 'iceMassAll', 'iceMassAbove', 'bedrockBelowSeaLevel',
    'total seawater volume', 'totalWaterVolume', 'totalWaterVolume2', 'bedrockBelowOcean']

    data: dict = {}
    for var in headers:
        timeseries: list[str] = re.findall(f'{var} = (-?\d+\.\d+e[+-]\d+)', txt)
        data[var] = list(map(float, timeseries))
    df = DataFrame(data)
    
    # fix issue with duplicate time values (see function below - probably unnecessary for most)
    df = fix_duplicate_time(df)

    return df


def fix_duplicate_time(df: DataFrame) -> DataFrame:

    '''
    Fixes an issue where some of my ensemble members had duplicate time coordinates
    (e.g. 30, 30, 60, 90, ...). This removes the duplicates and re-indexes the time axis by 
    adding multiples of 30 to the end. Lines of data after 10,000 years are then trimmed off.

    input: DataFrame of data from a GIAstats file
    output: Corrected DataFrame
    '''

    # drop duplicates
    time: np.array = df['time'].drop_duplicates().values
    
    # add time coords on end to replace dropped duplicates
    elements_to_add: int = len(df['iceVolumeAll']) - len(time)
    if elements_to_add > 0:
        additional_elements: np.array = time[-1] + 30 * np.arange(1, elements_to_add+1)
        fixed_time: np.array = np.concatenate([time, additional_elements])
        df['time'] = fixed_time

    # trim runs that go over 10,000 years because of added time coords
    df = df[df['time']<10_000]

    return df


def main(filepath: str) -> None:

    '''
    Converts summary.txt file to a csv in the same directory

    input: path to summary.txt file as string
    '''

    path = Path(filepath)

    try:
        content: str = path.read_text()
    except FileNotFoundError:
        return
    
    df: DataFrame = txt_to_df(content)
    csv_path: Path = path.with_suffix('.csv')
    df.to_csv(csv_path)


if __name__ == '__main__':
    if len(sys.argv) != 2:
        raise SystemExit('Usage: python summary_to_csv.py <path/to/summary.txt>')
    else:
        filepath = sys.argv[1]
        main(filepath)