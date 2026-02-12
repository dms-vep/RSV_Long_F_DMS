---
aside: false
---

# Natural sequences with mutations that affect antibodies

The deep mutational scanning data can be used to score natural RSV sequences for their antibody resistance under an additive model of mutational effects.

We have implemented this scoring into the Nextstrain RSV build so that you can visualize phylogenetic trees colored by the predicted antibody "escape score" of each sequence under this additive model (see the [Nextstrain RSV GitHub repo](https://github.com/nextstrain/rsv) for the implementing computer code).
These visualizations are useful for identifying natural strains that have reduced neutralization.
The Nextstrain RSV trees are updated regularly to include the latest sequences from [Pathoplexus](https://pathoplexus.org/).
Note the caveat that the scores assume the measurements made on the subtype A strain used in the deep mutational scanning accurately extrapolate in an additive fashion to other strains.

For both nirsevimab and clesrovimab, we have implemented two scores: the *total* escape caused by all mutations in that strain, and the *max* escape caused by the mutation measured to cause the greatest reduction in neutralization.
These scores are calculated separately using the deep mutational scanning data for the IgG and Fab form of each antibody.
They are available as colorings on the Nextstrain phylogenetic trees; you can also color by the top escape mutation.

These scores are implemented in both the *F* builds on Nextstrain (which sample available RSV F sequences in what is designed to be a representative fashion) and on *F-antibody-escape* builds that sample available RSV F sequences in a way designed to include strains with the highest escape.
So the former should be used if you want an unbiased view of the prevalence of resistance, and the latter if you want trees that help you find the most resistant strains.
(Note both builds are subsampled as are most Nextstrain trees as there are too many F sequences to effectively visualize them all on a single tree).

Here are some links:
 
 - [RSV B F-antibody-escape build colored by total nirsevimab escape measured with Fab](https://nextstrain.org/rsv/b/F-antibody-escape/6y?c=Nirsevimab-Fab_total_escape) (so this tree is enriched for F sequences with high antibody escape)
 - [RSV B F build colored by total nirsevimab escape measured with Fab](https://nextstrain.org/rsv/b/F/6y?c=Nirsevimab-Fab_total_escape) (so this tree is an unbiased subsample of F sequences)
 - [RSV A F-antibody-escape build colored by total nirsevimab escape measured with Fab](https://nextstrain.org/rsv/a/F-antibody-escape/6y?c=Nirsevimab-Fab_total_escape) (so this tree is enriched for F sequences with high antibody escape)
 - [RSV A F build colored by total nirsevimab escape measured with Fab](https://nextstrain.org/rsv/a/F/6y?c=Nirsevimab-Fab_total_escape) (so this tree is an unbiased subsample of F sequences)

For each of these trees, you can change what property it is colored by (eg, clesrovimab versus nirsevimab, max versus total escape, etc) by using the *Color By* dropdown in the toolbar at left on the Nextstrain page.
You can change which dataset is shown (eg, subtype, date range, build) using the *change dataset* dropdown in the toolbar at left on the Nextstrain page.
The trees are also fully interactive, so mouse over points, make selections, etc.

We recommend going to the separate standalone links above, but here is an embedded view if you prefer that:

<iframe src="https://nextstrain.org/rsv/b/F-antibody-escape/6y?c=Nirsevimab-Fab_total_escape" width="100%" height="1200px"></iframe>
