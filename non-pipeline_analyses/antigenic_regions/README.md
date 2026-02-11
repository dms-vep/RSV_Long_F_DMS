# antigenic_regions

This directory contains notebooks, data, and helpers for analysis of cell entry effects for mutations in defined antigenic regions. Entry functional effects are read directly from the pipeline output at `../../results/func_effects/averages/293T-TIM1_entry_func_effects.csv`.


## Contents
- `Cell_entry_by_region.ipynb`: Notebook exploring cell entry effects by broadly defined antigenic regions based on DOI:10.1016/j.tim.2017.09.009.
- `Nirsev_Cles_AgRegion_CellEntryEffects.ipynb`: Notebook focused on Nirsevimab/Clesrovimab antigenic regions and cell entry effects. Antigenic regions for these antibodies is defined as sites/residues that bury greater than or equal to 5 angstroms of surface area upon Fab binding for MEDI8897 Fab bound to RSV PreF in PDB 5UDC for nirsevimab and RB1 Fab bound to RSV PreF in PDB 6OUS for clesrovimab.
- `filtered_cell_entry.csv`: Filtered cell entry dataset used by the notebooks.
- `site_numbering_map.csv`: Mapping file for site numbering.
- `theme.py`: Plot styling/theme helpers used in notebooks.
- `output/`: Directory created at runtime containing HTML figures output by the notebooks.
  - `cell_entry_by_region_color.html`: Colored version of the cell entry by antigenic region plot.
  - `cell_entry_by_region_grayscale.html`: Grayscale version of the cell entry by antigenic region plot.
  - `nirsev_cles_antigenic_region_cell_entry.html`: Cell entry effects for Nirsevimab and Clesrovimab antigenic regions.
