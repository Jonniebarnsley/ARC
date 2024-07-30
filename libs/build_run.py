import pandas as pd
from pathlib import Path

# specify ensemble name and directories as appropriate
home = Path('/home/home01/earjbar')
nobackup = Path('/nobackup/earjbar')
ensemble_name = 'tests'
ensemble_dir = nobackup / ensemble_name

data = nobackup / 'data'                     
ppe = home / 'csvs' / 'PPE.csv'                  
templates = home / 'templates_ssp'

run_name = 'exactlyMira'

# constants
LEV = 2         # levels of refinement
TAGCAP = LEV-1  # highest level tagged for refinement
NCELLS = 768    # number of cells pre-refinement (16 km base resolution for 6144 km grid)

# dictionary to match ISMIP gamma0 values with deltaT files
dT_percentile = {
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
    if num != '083':
        continue # use only run 083 for testing

    id = f'{ensemble_name}-exp{num}' # id for naming files

    # make directory for ensemble member
    run_directory = ensemble_dir / run_name
    run_directory.mkdir(parents=True) 

    # perturbed parameters taken from PPE csv
    gamma0 = row['gamma0']
    UMV = row['UMV']
    LRP = row['LRP']
    PDDi = row['PDDi']
    WeertC = row['WeertC']
    model = row['model']

    # ISMIP ocean forcing correction
    deltaT = data / 'dT' / f'coeff_gamma0_DeltaT_quadratic_non_local_{dT_percentile[gamma0]}_16km_384.2d.hdf5'

    # set up dictionary to make substitutions
    substitutions = {
        '@ID'           :   id,
        '@JOBID'        :   run_name,    
        '@NCELLS'       :   NCELLS,         
        '@TAGCAP'       :   TAGCAP,
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
        outfile_name = template.name.replace('template', id)
        outfile = run_directory / outfile_name
        outfile.write_text(script)
