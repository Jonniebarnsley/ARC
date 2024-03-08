import pandas as pd
from pathlib import Path

# specify ensemble name and directories as appropriate
ensemble_name = 'ensemble'
home = Path('ARC') 
data = home / 'data'                     
ppe = data / 'PPE.csv'                  
templates = home / 'templates'
                  
ensemble_dir = home / ensemble_name     

# constants
LEV = 2         # levels of refinement
TAGCAP = LEV-1  # highest level tagged for refinement
NCELLS = 384    # number of cells pre-refinement (16 km base resolution for 6144 km grid)

# forcings
temp = data / 'RACMO_T2m_1979_2000_8000m_T2m_768.nc'
precip = data / 'RACMO_precip_1979_2000_8000m_precip_768.nc'
ISMIP_ocean_forcing = data / 'obs_thermal_forcing_1995-2017_16km_bisicles_compatible.hdf5'
init_height = data / 'RACMO_T2m_precip_1979_2000_8000m_height_768.nc'

# dictionary to match ISMIP gamma0 values with deltaT files
dT_file = {
    9618.882299     :   '5th_percentile',
    14477.33676     :   'median',
    21005.34364     :   '95th_percentile',
    86984.00071     :   '5th_pct_PIGL_gamma_calibration',
    159188.5414     :   'median_PIGL_gamma_calibration',
    471264.2917     :   '95th_pct_PIGL_gamma_calibration'
}

df = pd.read_csv(ppe)
for i, row in df.iterrows():

    num = f'{i+1:03}' # 3 digit number between 001 and 120
    run_directory = ensemble_dir / f'run{num}'
    run_directory.mkdir(parents=True) # make directory for ensemble member

    # strings for naming files
    id = f'AIS-BH-GIA-{ensemble_name}-exp{num}.{LEV}lev' # id for plot/checkpoint files
    name = f'{ensemble_name}-{num}' # name to replace 'template' in filenames
    jobid = f'run{num}' # label for naming jobs on the hpc

    # perturbed parameters taken from PPE csv
    gamma0 = row['gamma0']
    UMV = row['UMV']
    LRP = row['LRP']
    PDDi = row['PDDi']
    WeertC = row['WeertC']
    model = row['model']

    # ISMIP ocean forcing correction
    deltaT = data / f'coeff_gamma0_DeltaT_quadratic_non_local_{dT_file[gamma0]}_16km_384.2d.hdf5'

    # set up dictionary to make substitutions
    substitutions = {
        '@ID'           :   id,
        '@JOBID'        :   jobid,    
        '@NAME'         :   name,
        '@NCELLS'       :   NCELLS,         
        '@TAGCAP'       :   TAGCAP,
        '@TEMP'         :   temp,
        '@PRECIP'       :   precip,
        '@ISMIP_OCEAN'  :   ISMIP_ocean_forcing,
        '@HEIGHT'       :   init_height,
        '@gamma0'       :   gamma0,
        '@UMV'          :   UMV,
        '@LRP'          :   LRP,
        '@PDDi'         :   PDDi,
        '@WeertC'       :   WeertC,
        '@DELTAT'       :   deltaT
    }

    # do substitutions and write files
    for template in templates.iterdir():
        if template.name == '.DS_Store': # skip hidden files like this
            continue

        template_content = template.read_text()

        # iterate over substitutions dictionary and edit template accordingly
        script = template_content
        for placeholder, value in substitutions.items():
            script = script.replace(placeholder, str(value))

        # write edited script to file in the directory for this ensemble member
        outfile_name = template.name.replace('template', name)
        outfile = run_directory / outfile_name
        outfile.write_text(script)