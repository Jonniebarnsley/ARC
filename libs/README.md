Useful scripts for running BISICLES on ARC and processing its outputs.

### items

- `count_files.sh`: Simple utility to count the number of files in a directory
- `doGIAstats.sh`: Uses the BISICLES GIAstats tool to calculate summary stats from BISICLES plotfiles
- `AggregateGIAstats.sh`: Concatenates a directory of individual stats files into a single summary file
- `summary_to_csv.py`: Converts a summary_stats.txt file into a csv
- `ensemble_to_csv.py`: Iterates over run directories in an ensemble and converts summary_stats.txt files into csvs
- `CalculateEnsembleSLC.py`: Generates timeseries data for sea level contribution in an ensemble
