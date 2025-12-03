"""Custom rules used in the ``snakemake`` pipeline.

This file is included by the pipeline ``Snakefile``.

"""

# Configure dms-viz JSONs ---------------------------------------------------------------

# read configuration for `configure_dms_viz`
with open("data/dms_viz_config.yaml") as f:
    dms_viz_config = yaml.YAML(typ="safe", pure=True).load(f)

rule configure_dms_viz:
    """Configure a JSON for `dms-viz`."""
    input:
        data_csv=lambda wc: dms_viz_config[wc.viz_name]["data_csv"],
        sitemap_csv=lambda wc: dms_viz_config[wc.viz_name]["sitemap_csv"],
        nb="notebooks/configure_dms_viz.ipynb",
    output:
        dms_viz_json="results/dms-viz/{viz_name}/{viz_name}.json",
        pdb_file="results/dms-viz/{viz_name}/{viz_name}.pdb",
        input_data_csv="results/dms-viz/{viz_name}/{viz_name}_data.csv",
        input_sitemap_csv="results/dms-viz/{viz_name}/{viz_name}_sitemap.csv",
        nb="results/notebooks/configure_dms_viz_{viz_name}.ipynb",
    params:
        params_yaml=lambda wc: yaml_str(
            {
                key: dms_viz_config[wc.viz_name][key]
                for key in [
                    "pdb_id",
                    "pdb_type",
                    "name",
                    "melt_condition_metric_cols",
                    "metric",
                    "opt_params",
                ]
            }
        ),
    conda:
        "envs/dms-viz.yml"
    log:
        "results/logs/configure_dms_viz_{viz_name}.txt",
    shell:
        """
        papermill {input.nb} {output.nb} \
            -p data_csv {input.data_csv} \
            -p sitemap_csv {input.sitemap_csv} \
            -p dms_viz_json {output.dms_viz_json} \
            -p pdb_file {output.pdb_file} \
            -p input_data_csv {output.input_data_csv} \
            -p input_sitemap_csv {output.input_sitemap_csv} \
            -y "{params.params_yaml}" \
            &> {log}
        """

docs["dms-viz visualizations"] = {
    "dms-viz JSON files": {
        viz_name: rules.configure_dms_viz.output.dms_viz_json.format(viz_name=viz_name)
        for viz_name in dms_viz_config
    },
    "Notebooks prepping dms-viz JSONs": {
        viz_name: rules.configure_dms_viz.output.nb.format(viz_name=viz_name)
        for viz_name in dms_viz_config
    },
}

# Make row-wrapped heatmaps -------------------------------------------------------------

# read configuration for wrapped heatmaps
with open("data/wrapped_heatmap_config.yaml") as f:
    wrapped_heatmap_config = yaml.YAML(typ="safe", pure=True).load(f)


rule wrapped_heatmap:
    """Make row-wrapped heatmaps."""
    input:
        data_csv=lambda wc: wrapped_heatmap_config[wc.wrapped_hm]["data_csv"],
    output:
        chart_html="results/wrapped_heatmaps/{wrapped_hm}_wrapped_heatmap.html",
    params:
        params_dict=lambda wc: wrapped_heatmap_config[wc.wrapped_hm]
    log:
        notebook="results/notebooks/wrapped_heatmap_{wrapped_hm}.ipynb",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml"),
    notebook:
        "notebooks/wrapped_heatmap.py.ipynb"

docs["Row-wrapped heatmaps"] = {
    "Heatmap HTMLs" : {
        wrapped_hm: rules.wrapped_heatmap.output.chart_html.format(wrapped_hm=wrapped_hm)
        for wrapped_hm in wrapped_heatmap_config
    }
}

# Polymorphism analysis ------------------------------------------------------------------

# read configuration for polymorphism analysis
with open("data/polymorphism_analysis_config.yaml") as f:
    polymorphism_config = yaml.YAML(typ="safe", pure=True).load(f)

# Get list of strains from config (exclude common parameters)
polymorphism_strains = [key for key in polymorphism_config.keys()
                        if key not in ['cell_entry_file', 'figures_dir']]


rule find_variable_sites:
    """Identify variable sites from RSV F sequence alignments."""
    input:
        alignment=lambda wc: polymorphism_config[wc.strain]["alignment_file"],
        nb="notebooks/polymorphism_analysis/find_variable_sites.ipynb",
    output:
        variable_sites="results/polymorphisms/{strain}_variable_sites.csv",
        nb="results/notebooks/find_variable_sites_{strain}.ipynb",
    log:
        "results/logs/find_variable_sites_{strain}.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml"),
    shell:
        """
        papermill {input.nb} {output.nb} \
            -p strain {wildcards.strain} \
            -p alignment_file {input.alignment} \
            -p output_file {output.variable_sites} \
            &> {log}
        """


rule plot_polymorphism_effects:
    """Plot cell entry effects of naturally occurring polymorphisms."""
    input:
        variable_sites="results/polymorphisms/{strain}_variable_sites.csv",
        cell_entry=polymorphism_config["cell_entry_file"],
        nb="notebooks/polymorphism_analysis/plot_effect_of_polymorphisms.ipynb",
    output:
        polymorphisms_with_effects="results/polymorphisms/{strain}_polymorphisms_with_effects.csv",
        chart_html="results/polymorphisms/{strain}_polymorphism_effects.html",
        nb="results/notebooks/plot_effect_of_polymorphisms_{strain}.ipynb",
    log:
        "results/logs/plot_effect_of_polymorphisms_{strain}.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml"),
    shell:
        """
        papermill {input.nb} {output.nb} \
            -p strain {wildcards.strain} \
            -p variable_sites_file {input.variable_sites} \
            -p cell_entry_file {input.cell_entry} \
            -p output_csv {output.polymorphisms_with_effects} \
            -p output_html {output.chart_html} \
            &> {log}
        """


docs["Polymorphism analysis"] = {
    "Variable sites CSVs": {
        strain: rules.find_variable_sites.output.variable_sites.format(strain=strain)
        for strain in polymorphism_strains
    },
    "Polymorphisms with effects CSVs": {
        strain: rules.plot_polymorphism_effects.output.polymorphisms_with_effects.format(strain=strain)
        for strain in polymorphism_strains
    },
    "Interactive polymorphism plots": {
        strain: rules.plot_polymorphism_effects.output.chart_html.format(strain=strain)
        for strain in polymorphism_strains
    },
    "Polymorphism analysis notebooks": {
        f"find_variable_sites_{strain}": rules.find_variable_sites.output.nb.format(strain=strain)
        for strain in polymorphism_strains
    } | {
        f"plot_effect_of_polymorphisms_{strain}": rules.plot_polymorphism_effects.output.nb.format(strain=strain)
        for strain in polymorphism_strains
    },
}