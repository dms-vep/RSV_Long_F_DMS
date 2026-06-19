---
aside: false
---

# Human sera neutralization

This page shows how mutations to the F protein of RSV affect neutralization by five human sera. 
Note that [as described previously](https://journals.asm.org/doi/10.1128/jvi.00531-25), RSV F does not undergo particularly rapid antigenic evolution, and correspondingly these data show no mutations have particularly large effects on human sera neutralization.

[[toc]]

## Interactive heatmap of mutation effects on sera neutralization
Below is an interactive heatmap showing the effects of mutations on neutralization by five human sera.

The top lineplots at top show the total effect of all mutations at each site on neutralization, averaged across all five human sera.
The subsequent lineplots show the total effect of all mutations at each site on neutralization by each individual sera.
The top heatmap shows the effects of individual mutations on neutralization averaged across the sera, and the bottom heatmap shows the effects of mutations on F-mediated cell entry.
For antibody neutralization, positive "escape" values indicate a mutation reduces neutralization; by default these values are floored at zero (see *floor escape at zero* optiona t bottom of plot).
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
    <Altair :showShadow="true" :spec-url="'htmls/hSera_average_faceted.html'"></Altair>
</Figure>

Additional heatmaps showing the same data:

 - [standalone link to heatmap shown above](htmls/hSera_average_faceted.html){target="_self"}
 - [similar heatmap but showing a heatmap for each individual serum as well](htmls/all_hSera_faceted.html){target="_self"}

## Interactive structure colored by effects of mutations on serum neutralization (averaged across sera)
Below is an interactive view of the F pre-fusion conformation ([PDB 5c6b](https://www.rcsb.org/structure/5c6b)) colored by mutation effects on sera neutralization as rendered using [dms-viz](https://dms-viz.github.io/dms-viz-docs/).
The structure is colored by the total effects of mutations at each site on neutralization, you can rotate and view the structure as well as click on sites in the line plot to see more details and adjust other interactive options.
You can use the sidebar at left to select whether to show the IgG or Fab data.

<iframe src="https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fhuman_sera_escape_on_prefusion_F%2Fhuman_sera_escape_on_prefusion_F.json&sa=true&fi=%257B%2522cell_entry%2522%253A-2.5%257D" width="100%" height="600px"></iframe>

Additional structural views of the data:

  - [standalone version of plot shown above](https://dms-viz.github.io/v0/?data=https%3A%2F%2Fraw.githubusercontent.com%2Fdms-vep%2FRSV_Long_F_DMS%2Frefs%2Fheads%2Fmain%2Fresults%2Fdms-viz%2Fhuman_sera_escape_on_prefusion_F%2Fhuman_sera_escape_on_prefusion_F.json&sa=true&fi=%257B%2522cell_entry%2522%253A-2.5%257D)

## Numerical values of mutation effects on serum neutralization
Here are CSVs with the numerical values:

 - [CSV with measurements after the QC filtering used in above plots, for individual sera](https://github.com/dms-vep/RSV_Long_F_DMS/blob/main/results/summaries/all_hSera.csv)
 - [CSV with measurements after the QC filtering used in above plots, for across-sera average](https://github.com/dms-vep/RSV_Long_F_DMS/blob/main/results/summaries/hSera_average.csv)
 - Additional CSVs with per-replicate measurements and notebooks related to the data analysis are available in the [Appendix](appendix.html){target="_self"}.
