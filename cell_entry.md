---
aside: false
---

# Cell entry

This page shows how mutations to the F protein of RSV affect its ability to mediate pseudovirus entry into 293T-TIM1 cells.

[[toc]]

## Interactive heatmap of mutation effects on cell entry
Below is an interactive heatmap showing the effects of mutations.

In the heatmap, each square gives the effect of a different mutation on cell entry: negative effects indicate impaired entry, effects of zero indicate mutation has no effect, and positive values indicate enhanced entry.
At each site the `x` indicates the amino-acid identity in the parental subtype A strain used for the deep mutational scanning, and mutations that were not reliably measured in the experiments are shown as gray.
You can mouseover points for additional details and use the zoom bar to zoom in on specific regions.

The lineplot above the heatmap shows the the average effects of mutations at each site, and the zoom bar is colored by the antigenic region.

There are a variety of interactive options at the bottom which allow you to adjust the summary statistic shown in the line plot and apply filters such as how many different variants the mutation had be seen in for the experiments, the minimum number of experimental selections in which it had to be measured, etc.
Note also that mousing over mutations shows the measured effect in each of the six experimental replicates, which provides some measure of confidence.

Click on the box in the upper right of the plot to expand it to full page.

<Figure caption="">
    <Altair :showShadow="true" :spec-url="'htmls/293T-TIM1_entry_func_effects.html'"></Altair>
</Figure>

Additional heatmaps showing the same data:

 - [standalone link to heatmap shown above](htmls/293T-TIM1_entry_func_effects.html){target="_self"}
 - [heatmap with QC-filters pre-applied](htmls/cell_entry_overlaid.html){target="_self"}
 - [row-wrapped heatmap](htmls/rsvF_293T_TIM1_wrapped_heatmap.html){target="_self"}

## Interactive structure colored by effects of mutations on cell entry
Below is an interactive view of the F pre-fusion conformation ([PDB 5c6b](https://www.rcsb.org/structure/5C6B)) colored by mutation effects on cell entry as rendered using [dms-viz](https://dms-viz.github.io/dms-viz-docs/).
The structure is colored by the average effects of mutations at each site on cell entry, you can rotate and view the structure as well as click on sites in the line plot to see more details and adjust other interactive options.

<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fcell_entry_on_prefusion_F%2Fcell_entry_on_prefusion_F.json&sa=true" width="100%" height="600px"></iframe>

Additional structural views of the data:
  
  - [standalone link to visualization on pre-fusion conformation shown above](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fcell_entry_on_prefusion_F%2Fcell_entry_on_prefusion_F.json&sa=true)
  - [effects of mutations on cell entry mapped onto post-fusion F structure](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fcell_entry_on_postfusion_F%2Fcell_entry_on_postfusion_F.json&sa=true)

## Numerical values of mutation effects on cell entry
Here are CSVs with the numerical values:

 - [CSV with measurements after the QC filtering used in above plots](https://github.com/dms-vep/RSV_Long_F_DMS/blob/main/results/summaries/cell_entry.csv); use these values unless you have a good understanding of the QC filtering
 - [CSV with all measurements prior to QC filtering](https://github.com/dms-vep/RSV_Long_F_DMS/blob/main/results/func_effects/averages/293T-TIM1_entry_func_effects.csv); this file has more information but only use if you know how to interpret the *times_seen* and *n_selections* QC filters.
 - Additional CSVs with per-replicate measurements and notebooks related to the data analysis are available in the [Appendix](appendix.html){target="_self"}.
