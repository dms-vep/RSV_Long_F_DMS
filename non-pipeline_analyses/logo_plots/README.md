# Logo plots 

This directory contains the data, notebooks, and outputs used to visualize effects of mutations on cell entry and neutralization by antibody IgG and Fab in logo plots. It is organized into raw/combined inputs, analysis notebooks, and output plots.

## Contents

- `01-data/` contains per-antibody mutation-effect inputs (IgG and Fab) and entry/function effects used to build logo plots.
- `01-data/*_mut_effect.csv` are mutation-effect tables for each antibody/isotype (for example `Nirsevimab-IgG_mut_effect.csv`, `RSM01-Fab_mut_effect.csv`).
- `01-data/293T-TIM1_entry_func_effects.csv` provides entry/function effects.

- `02-notebooks/` holds the plotting notebooks for each antibody or comparison.
- `02-notebooks/escape_logos_*_color.py.ipynb` generate the colored logo plots and associated mutation tables.

- `03-output/` contains rendered figures and the corresponding mutation tables used in the plots.
- `03-output/*_combined.(pdf|svg)` are final logo figures for each antibody or comparison.
- `03-output/*_mutations_shown_in_logo.csv` lists the mutations included in each logo.
- `03-output/scalebar_*.(pdf|svg)` are shared scale bars.

## Typical workflow

1. Start with the relevant input file(s) in `01-data/` (IgG/Fab mutation-effect tables, plus entry/function effects if needed).
2. Run the appropriate notebook(s) in `02-notebooks/` to generate the logos.
3. Use the figures and mutation tables in `03-output/` for reporting or downstream analyses.
