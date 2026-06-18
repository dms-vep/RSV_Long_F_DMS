# Logo plots 

This directory contains the notebooks and outputs used to visualize effects of mutations on cell entry and neutralization by antibody IgG and Fab in logo plots. Input data are read directly from pipeline results.

## Contents

Input data are read directly from the pipeline output directories:
- `../../results/antibody_escape/averages/*_mut_effect.csv` — mutation-effect tables for each antibody/isotype (for example `Nirsevimab-IgG_mut_effect.csv`, `RSM01-Fab_mut_effect.csv`).
- `../../results/func_effects/averages/293T-TIM1_entry_func_effects.csv` — entry/function effects.

- `notebooks/` holds the plotting notebooks for each antibody or comparison.
- `notebooks/escape_logos_*_color.py.ipynb` generate the colored logo plots and associated mutation tables.
- `notebooks/escape_logos_*_comparison_color.py.ipynb` plot multiple antibodies side-by-side for the same isotype (one grid row per antibody). These include the Nirsevimab/RSM01, Nirsevimab/RSM01/1B6, and Clesrovimab/1A2 comparisons. Each comparison notebook also produces a combined grid figure (`*_all_comparison.*`) with one column per isotype (IgG, Fab) and one row per antibody.

- `output/` contains rendered figures and the corresponding mutation tables used in the plots.
- `output/*_combined.(pdf|svg)` are final logo figures for each single antibody.
- `output/*_comparison.(pdf|svg)` are final logo figures comparing multiple antibodies for a given isotype.
- `output/*_all_comparison.(pdf|svg)` are combined grid figures with all antibodies and isotypes (columns = isotype, rows = antibody).
- `output/*_mutations_shown_in_logo.csv` lists the mutations included in each logo.
- `output/scalebar_*.(pdf|svg)` are shared scale bars.

## Typical workflow

1. Run the appropriate notebook(s) in `notebooks/` to generate the logos. Input data are read from the pipeline results directories above.
2. Use the figures and mutation tables in `output/` for reporting or downstream analyses.
