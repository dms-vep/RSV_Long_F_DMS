# Validation analyses and outputs

This directory contains the data, notebooks, and derived outputs used to validate DMS scores with pseudovirus neutralization assay results (including point mutants, strain-level validations, and DMS correlations). It is organized into raw/combined inputs, analysis notebooks, and finalized tables for downstream use.

## Contents

- `01_data/combined_frac_infect.csv` is the combined fraction-infectivity dataset that underlies the validation fits. Key columns include `serum`, `virus`, `replicate`, `concentration`, and `fraction infectivity`.

- `02_notebooks/Point_mutant_validations_final.ipynb` fits neutralization curves for point mutants and aggregates IC50/IC99 metrics.

- `02_notebooks/Strain_validations_final.ipynb` performs the strain-level validation analysis and aggregates IC50/IC99 metrics.

- `02_notebooks/DMS_validation_correlation_final.ipynb` compares validation results to DMS predictions and summarizes correlation metrics.

- `03_output/point_mut_combined_fit_params_IC50_IC99_molar.csv` contains fit parameters (IC50/IC99, slope, bounds, fit quality) for point mutants.

- `03_output/Strain_Validation_combined_fit_params_IC50_IC99_molar.csv` contains fit parameters (IC50/IC99, slope, bounds, fit quality) for strain validations.

- `03_output/point_mut_combined_fold_changes_vs_Long_B1.csv` and `03_output/point_mut_combined_fold_changes_vs_references.csv` summarize fold changes relative to Long and B1 references (including which WT controls were used and date matching flags).

## Typical workflow

1. Start with `01_data/combined_frac_infect.csv` as the input dataset.
2. Run the notebooks in `02_notebooks/` to fit curves and compute IC50/IC99 values.
3. Use the summarized tables in `03_output/` for plotting, reporting, or downstream analyses.
