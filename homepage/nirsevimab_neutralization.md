---
aside: false
---

# Nirsevimab neutralization

This page shows how mutations to the F protein of RSV affect neutralization of pseudovirus by the IgG and Fab forms of nirsevimab.

[[toc]]

## Interactive heatmap of mutation effects on nirsevimab neutralization
Below is an interactive heatmap showing the effects of mutations on neutralization by both the IgG and Fab forms of nirsevimab.

The lineplots at top show the total effect of all mutations at each site on neutralization.
The top two heatmaps show the effects of individual mutations on IgG or Fab neutralization, and the bottom heatmap shows the effects of mutations on F-mediated cell entry.
For antibody neutralization, positive "escape" values indicate a mutation reduces neutralization, while negative values indicate it reduces neutralization.
For cell entry, negative values indicate a mutation impairs F's cell entry function.

In the heatmaps, each square gives the effect of a different mutation.
At each site the `x` indicates the amino-acid identity in the parental subtype A strain used for the deep mutational scanning.
In the escape heatmaps, dark gray indicates a mutation is too deleterious for cell entry to reliably measure its effect on neutralization.
In all heatmaps, light gray squares (there are only a few of these) indicate mutations not reliably measured in the experiments.
You can mouseover points for additional details and use the zoom bar to zoom in on specific regions.

There are interactive options at the bottom which allow you to adjust the summary statistic in the line plots,
 adjust how deleterious a mutation must be for cell entry before it is grayed out (dark gray), and show only positive or both positive and negative escape.

Click on the box in the upper right of the plot to expand it to full page.

<Figure caption="">
    <Altair :showShadow="true" :spec-url="'htmls/Nirsevimab_faceted.html'"></Altair>
</Figure>

Additional heatmaps showing the same data:

 - [standalone link to heatmap shown above with effects of mutations on IgG neutralization, Fab neutralization, and cell entry](htmls/Nirsevimab_faceted.html){target="_self"}
 - [similar heatmap but showing effects on both nirsevimab and clesrovimab neutralization](htmls/Nirsevimab-and-Clesrovimab_faceted.html){target="_self"}
 - [similar heatmap but showing effects on neutralization by all antibodies characterized in this study](htmls/all_antibodies_faceted.html){target="_self"}
 - [heatmap showing effects of mutations on nirsevimab IgG neutralization with additional filters and mouseovers giving per-experimental-replicate values](htmls/Nirsevimab-IgG_mut_effect.html){target="_self"}; this is the best heatmap if you want to assess the quality of any specific measurement in detail.
 - [heatmap showing effects of mutations on nirsevimab Fab neutralization with additional filters and mouseovers giving per-experimental-replicate values](htmls/Nirsevimab-Fab_mut_effect.html){target="_self"}; this is the best heatmap if you want to assess the quality of any specific measurement in detail.

## Interactive structure colored by effects of mutations on nirsevimab neutralization
Below is an interactive view of the F pre-fusion conformation in complex with nirsevimab ([PDB 5udc](https://www.rcsb.org/structure/5udc)) colored by mutation effects on nirsevimab neutralization as rendered using [dms-viz](https://dms-viz.github.io/dms-viz-docs/).
The structure is colored by the total effects of mutations at each site on neutralization, you can rotate and view the structure as well as click on sites in the line plot to see more details and adjust other interactive options.
You can use the sidebar at left to select whether to show the IgG or Fab data.

<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2FNirsevimab_bound_F_escape%2FNirsevimab_bound_F_escape.json&sa=true&fi=%257B%2522cell_entry%2522%253A-2.5%257D&bc=%23ece9a2" width="100%" height="600px"></iframe>

Additional structural views of the data:

  - [standalone link to visualization on nirsevimab-bound pre-fusion conformation shown above](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2FNirsevimab_bound_F_escape%2FNirsevimab_bound_F_escape.json&sa=true&fi=%257B%2522cell_entry%2522%253A-2.5%257D&bc=%23ece9a2)
  - [effects of mutations on cell entry mapped onto nirsevimab-bound pre-fusion F structure](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2FNirsevimab_bound_F_cell_entry%2FNirsevimab_bound_F_cell_entry.json&sa=true&lc=%23dddb97&bc=%23e4e599)
  - [effects of mutations on neutralization by all antibodies visualized on pre-fusion F conformation](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fantibody_escape_on_prefusion_F%2Fantibody_escape_on_prefusion_F.json); use the sidebar at left to select which antibody is shown.
  - [effects of mutations on neutralization by all antibodies visualized on post-fusion F conformation](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fantibody_escape_on_postfusion_F%2Fantibody_escape_on_postfusion_F.json); use the sidebar at left to select which antibody is shown.

## Numerical values of mutation effects on nirsevimab neutralization
Here are CSVs with the numerical values:

 - [CSV with measurements after the QC filtering used in above plots](https://github.com/dms-vep/RSV_Long_F_DMS/blob/main/results/summaries/Nirsevimab.csv); use these values unless you have a good understanding of the QC filtering
 - CSVs with all measurements prior to QC filtering; these files have more information but only use if you know how to interpret the *times_seen* and *n_models* QC filters:
   + [IgG neutralization](https://github.com/dms-vep/RSV_Long_F_DMS/blob/main/results/antibody_escape/averages/Nirsevimab-IgG_mut_effect.csv)
   + [Fab neutralization](https://github.com/dms-vep/RSV_Long_F_DMS/blob/main/results/antibody_escape/averages/Nirsevimab-Fab_mut_effect.csv)
  - [CSV with QC-filtered values for all antibodies characterized in this study](https://github.com/dms-vep/RSV_Long_F_DMS/blob/main/results/summaries/all_antibodies.csv)
 - Additional CSVs with per-replicate measurements and notebooks related to the data analysis are available in the [Appendix](appendix.html){target="_self"}.
