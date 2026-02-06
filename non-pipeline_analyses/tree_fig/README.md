# Make nicely formatted Baltic trees for paper figures

This repository uses [Baltic](https://github.com/evogytis/baltic) to make nicely formatted paper figures of trees.

[./nextstrain_rsv](nextstrain_rsv) is a copy of the Nextstrain RSV build branch created by Jesse to preferentially subsample strains with high escape, taken from [here](https://github.com/jbloomlab/rsv/tree/DMS-data-for-F). It was modified to only build the *F-antibyd-escape* trees at *6Y* resolution, to plot fewer sequences than the Nextstrain builds, and to ensure the filtering of sequences includes the accessions in [nextstrain-rsv/config/accessions_to_include.txt](nextstrain-rsv/config/accessions_to_include.txt) which are the ones of interest here. It was also modified so that the [./nextstrain_auspice](nextstrain_auspice) subdirectory which has the trees is tracked by git. That repo should then be run separately to create the tree JSONs in  [./nextstrain_auspice](nextstrain_auspice).

[validation_strain_info_final.csv](validation_strain_info_final.csv) has the strains of interest that we want to label on the tree. We label each of these strains with the label in the *tree_label* column. These are the trees used in the experiments. If you want to change the labels used on the trees, update this column.

[./baltic](baltic) has the [baltic](https://github.com/evogytis/baltic) tree plotting package added as a git submodule.

To build the trees, create and activate the conda environment in [environment.yml](environment.yml).

Then run the Python script [make_tree_fig.py](make_tree_fig.py), and the output trees are saved in [./results](results).

## Implementation of `make_tree_fig.py`

This script generates tree figures from Nextstrain Auspice JSON files, creating two versions of each tree: one colored by Nirsevimab escape and one by Clesrovimab escape.

### Input Files
- **Tree JSONs**: `./nextstrain-rsv/auspice/rsv_{a,b}_F-antibody-escape_6y.json` (2 files; `_tip-frequencies.json` files are skipped)
- **Validation strains**: `./validation_strain_info_final.csv` with columns: Name, background, mutation, mAb, accession, strain, tree_label, subtype
- **Baltic package**: `./baltic/baltic/baltic.py`

### Key Technical Details

**Accession Matching**: CSV accessions (e.g., `PP_001WGC0`) lack version suffixes, while tree accessions include them (e.g., `PP_001WGC0.1` in `node_attrs.PPX_accession.value`). The script matches using prefix comparison.

**Strain Labeling Logic**: For each antibody-specific figure, the script labels only:
- Strains where the `mAb` column matches the antibody name (e.g., "Nirsevimab" or "Clesrovimab")
- Strains where the `mAb` column contains "control" (these appear on both figures)

**Escape Attributes**:
- Nirsevimab: `Nirsevimab-Fab_total_escape`
- Clesrovimab: `Clesrovimab-Fab_total_escape`

### Output
4 PDF files in `./results/` (2 per tree, one for each antibody):
- `rsv_a_F-antibody-escape_6y_Nirsevimab.pdf`
- `rsv_a_F-antibody-escape_6y_Clesrovimab.pdf`
- `rsv_b_F-antibody-escape_6y_Nirsevimab.pdf`
- `rsv_b_F-antibody-escape_6y_Clesrovimab.pdf`

### Visual Design
- **Title**: Centered title indicating subtype and antibody (e.g., "RSV subtype A, predicted nirsevimab neutralization")
- **Time axis**: X-axis shows calendar years (2012-2026), with tree trimmed at 2012; scale bar ends at 2026 but labels can extend beyond; "date" label below the axis
- **Branch coloring**: Viridis colormap based on antibody-specific Fab total escape values
- **Tip markers**: All tips shown as small circles colored by escape value
- **Labeled strains**: Larger square markers with black outline, colored by escape value
- **Labels**: Strain names from `tree_label` column, right-aligned with thin dotted lines connecting to tips; overlapping labels are automatically spread apart vertically with angled connector lines
- **Colorbar**: Horizontal, positioned in lower left above the time scale, labeled "neutralization escape"

### Error Handling
The script fails fast with informative errors:
- Raises `ValueError` if any expected strain is missing from a tree
- Clear error messages indicate which accessions are missing
