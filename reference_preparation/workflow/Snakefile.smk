from collections import defaultdict
import shutil
import pandas as pd
from scripts.utils import *

configfile: "config.yaml"

config = init_default_config(config)

workdir: config['workdir']

####--------------- Get Sample info -----------------####
# samples = pd.read_csv(os.path.join(config['workdir'],config["data_table"])).set_index("Sample_Name", drop=False)
# miseq_dirs = config['input_data_dirs'].values()

# if config['use_default_sheets']:
#     sample_sheets = []
#     for miseq_dir in miseq_dirs:
#         miseq_home = config["miseq_output"]
#         sample_sheet = os.path.join(miseq_home,miseq_dir,'SampleSheet.csv')
#     sample_sheets.append(sample_sheet)
# else:
#     sample_sheets = config['illumina_sample_sheets'].values()

# wildcard_constraints:
#     # requried for agg step, miseq file format of {6#'s}_M{5#'s}_{4#'s}_{9zeros}-{5char}
#     miseq_dir="\d{6}_M\d{5}_\d{4}_0{9}-.{5}" 

# dictionary to correspond each of the directories with their matching sample sheet
# samp_sheet_dict, samp_dict, samps = match_sample_sheets(miseq_dirs,sample_sheets,config['bad_run'])

# df_list = []
# for sample_sheet in sample_sheets:
#     df_t = read_sample_sheet(sample_sheet).set_index("Sample_Name", drop=False)
#     df_list.append(df_t)

# sample_ref = pd.concat(df_list)
# samps = sample_ref.index.values

####--------------- Get Sample info -----------------####
refs = pull_refs(config['reference'],config['workdir']) 

rule all:
    input:
        expand("ref/{ref}.fa",ref=refs),

include: 'rules/fmt_ref.smk'
