import os
import pandas as pd
from pathlib import Path

home = Path('ARC')
ppe = home / 'PPE.csv'
templates = home / 'templates'
ensemble = home / 'Ensemble'
ensemble.mkdir(exist_ok=True)

df = pd.read_csv(ppe)

# dictionary to match ISMIP gamma0 values with deltaT files
dT_file = {
    9618.882299     :   '5th_percentile',
    14477.33676     :   'median',
    21005.34364     :   '95th_percentile',
    86984.00071     :   '5th_pct_PIGL_gamma_calibration',
    159188.5414     :   'median_PIGL_gamma_calibration',
    471264.2917     :   '95th_pct_PIGL_gamma_calibration'
}

for i, row in df.iterrows():

    run_dir = ensemble / f'run{i+1:03}'
    run_dir.mkdir(exist_ok=True)

    # constants
    lev = 2
    TAGCAP = lev-1
    NCELLS = 384
    NCORES = 24

    # file and directory names
    model = row['model']
    id = f'AIS-BH-GIA-exp{i+1:03}.{lev}lev'
    expname = f'run{i+1:03}'
    dirname = f'run{i+1:03}_{model}'
    infile = f'inputs.{id}'
    infilerelax = f'inputs.relax.{i+1:03}.${lev}lev'
    job = f'job.{id}.sh'
    initsmb = f'Init_SMB_{i+1:03}.py'
    pddname = f'PDD_RatioEC_control_{i+1:03}.py'
    wrapper = f'wrapper.{i+1:03}.sh'
    chk = f'chk.{id}*'

    # params
    g0 = row['gamma0']
    deltaT = f'coeff_gamma0_DeltaT_quadratic_non_local_{dT_file[g0]}_16km_384.2d.hdf5'
    UMV = row['UMV']
    LRP = row['LRP']
    PDDi = row['PDDi']
    C = row['WeertC']

    BFC = f'bedFricCalculate_AIS-BH-GIA-exp-{i+1:03}'

    substitutions = {
        '@MODEL'        :   model,
        '@EXPNAME'      :   expname,
        '@ID'           :   id,         # change all references to @NAME to @ID
        '@INFILE'       :   infile,
        '@JOB'          :   job,
        '@INITSMB'      :   initsmb,
        '@PDDNAME'      :   pddname,
        '@wrapper'      :   wrapper,
        '@checkpoints'  :   chk,
        '@gamma0'       :   g0,
        '@DELTAT'       :   deltaT,
        '@UMV'          :   UMV,
        '@LRP'          :   LRP,
        '@PDDi'         :   PDDi,
        '@WeertC'       :   C,
        '@TAGCAP'       :   TAGCAP,
        '@NCELLS'       :   NCELLS,
        '@BFC'          :   BFC
    }

    # replace @NAME with relax_@ID in inputs.ant_relax_template_cosmos
    # replace @NAME with relax_@ID in job.relax_template.sh
    # replace @NAME with @EXPNAME in templates/job.template.sh

    for template in templates.iterdir():
        if template.name == '.DS_Store':
            continue
        with open(template, 'r') as file:
            template_content = file.read()

        for placeholder, value in substitutions.items():
            script = template_content.replace(placeholder, str(value))

        outfile_name = template.name.replace('template', f'{i+1:03}')
        outfile = run_dir / outfile_name

        with open(outfile, 'w') as f:
            f.write(script)

