import pandas as pd
from pathlib import Path

# specify ensemble name and directories as appropriate
ensemble_name = 'ensemble'
home = Path('ARC')                      
ppe = home / 'PPE.csv'                  
templates = home / 'templates'
data = home / 'data'                    
ensemble_dir = home / ensemble_name     

# constants
LEV = 2         # levels of refinement
TAGCAP = LEV-1  # highest level tagged for refinement
NCELLS = 384    # number of cells pre-refinement (16 km base resolution for 6144 km grid)

# forcings
temp = data / 'RACMO_T2m_1979_2000_8000m_T2m_768.nc'
precip = data / 'RACMO_precip_1979_2000_8000m_precip_768.nc'
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

    num = f'{i+1:03}'
    run = ensemble_dir / f'run{num}'
    run.mkdir(parents=True)

    # filenames
    id = f'AIS-BH-GIA-{ensemble_name}-exp{num}.{LEV}lev'
    name = f'{ensemble_name}-{num}'
    jobid = f'run{num}'

    # params
    gamma0 = row['gamma0']
    UMV = row['UMV']
    LRP = row['LRP']
    PDDi = row['PDDi']
    WeertC = row['WeertC']
    deltaT = f'coeff_gamma0_DeltaT_quadratic_non_local_{dT_file[gamma0]}_16km_384.2d.hdf5'

    substitutions = {
        '@ID'           :   id,
        '@JOBID'        :   jobid,    
        '@NAME'         :   name,
        '@NCELLS'       :   NCELLS,         
        '@TAGCAP'       :   TAGCAP,
        '@TEMP'         :   temp,
        '@PRECIP'       :   precip,
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
        if template.name == '.DS_Store':
            continue

        with open(template, 'r') as file:
            template_content = file.read()

        script = template_content
        for placeholder, value in substitutions.items():
            script = script.replace(placeholder, str(value))

        outfile_name = template.name.replace('template', name)
        outfile = run / outfile_name
        with open(outfile, 'w') as f:
            f.write(script)