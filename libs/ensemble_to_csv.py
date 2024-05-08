import re
import sys
import numpy as np
import pandas as pd
from pathlib import Path
from summary_to_csv import txt_to_df

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
        raise SystemExit('Usage: python summary_to_csv.py <ensemble_path>')
    else:
        ensemble = sys.argv[1]
        main(ensemble)
