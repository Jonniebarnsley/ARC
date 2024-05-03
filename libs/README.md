Useful scripts for running BISICLES on ARC and processing its outputs.

### items

| Script                    | Description                                                                                   |
|---------------------------|-----------------------------------------------------------------------------------------------|
| `AggregateGIAstats.sh`    | Aggregates a directory of individual stats files into a single summary file                   |
| `AggregateRun.sh`         | Aggregates stats for all basins in a run into individual summary files                        |
| `CalculateEnsembleSLC.py` | Generates timeseries data for sea level contribution in an ensemble                           |
| `GIAstats.sh`             | Uses the BISICLES GIAstats tool to calculate summary stats from BISICLES plotfiles            |
| `all_txt_to_csv.sh`       | Converts all summary txt files into csvs using summary_to_csv.py                              |
| `ensemble_to_csv.py`      | Iterates over run directories in an ensemble and converts summary_stats.txt files into csvs   |
| `generate_PPE.py`         | Creates directories and job scripts for all runs in an ensemble                               |
| `make_GIAstats_jobs.sh`   | Makes and/or queues jobs in each run for processing GIAstats                                  |
| `mk_inputs_AIS_control_ensemble.sh` | Deprecated version of `generate_PPE.py` in bash                                     |
| `process_thickness.sh`    | Job script to process thickness netcdfs for an ensemble (using parallel processing)           |
| `runGIAstats.sh`          | Deprecated script for calculating GIAstats for IMBIE basins                                   |
| `run_to_netcdf.py`        | Extracts variable data from hdf5 plotfiles and generates a netcdf                             |
| `run_to_netcdf_archer2.py`| Slightly adapted version of `run_to_netcdf.py` for use on ARCHER2                             |
| `statstools.sh`           | Simple script to use stats tool on a plotfile with options for mask and basin                 |
| `summary_to_csv.py`       | Converts a summary_stats.txt file into a csv                                                  |
| `utils.sh`                | Some useful miscellaneous functions                                                           |

