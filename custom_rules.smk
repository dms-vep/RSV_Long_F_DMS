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

# Sequence variation analysis ------------------------------------------------------------------

# read configuration for sequence variation analysis
with open("data/sequence_variation_config.yaml") as f:
    seq_var_config = yaml.YAML(typ="safe", pure=True).load(f)

# Get list of analysis configurations (exclude common parameters)
seq_var_analyses = [key for key in seq_var_config.keys()
                        if key not in ['cell_entry_file', 'figures_dir']]


rule find_variable_sites:
    """Identify variable sites from RSV F sequence alignments and calculate cell entry effects."""
    input:
        alignment=lambda wc: seq_var_config[wc.analysis]["alignment_file"],
        cell_entry=seq_var_config["cell_entry_file"],
        nb="notebooks/sequence_variation/find_variable_sites.ipynb",
        effect_ref_file=lambda wc: seq_var_config[wc.analysis]["alignment_file"] if "effect_reference_name" in seq_var_config[wc.analysis] else [],
    output:
        variations_with_effects="results/sequence_variation/{analysis}_sequence_variations_with_effects.csv",
        nb="results/notebooks/find_variable_sites_{analysis}.ipynb",
    params:
        reference_name=lambda wc: seq_var_config[wc.analysis]["reference_name"],
        strain_label=lambda wc: seq_var_config[wc.analysis]["strain_label"],
        analysis_description=lambda wc: seq_var_config[wc.analysis]["analysis_description"],
        mutation_identified_relative_to=lambda wc: seq_var_config[wc.analysis]["mutation_identified_relative_to"],
        effects_calculated_relative_to=lambda wc: seq_var_config[wc.analysis]["effects_calculated_relative_to"],
        min_mutation_count=lambda wc: seq_var_config[wc.analysis]["min_mutation_count"],
        effect_reference_name=lambda wc: seq_var_config[wc.analysis].get("effect_reference_name", ""),
    log:
        "results/logs/find_variable_sites_{analysis}.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml"),
    run:
        # Build papermill command
        cmd = f"""papermill {input.nb} {output.nb} \
            -p strain {params.strain_label} \
            -p alignment_file {input.alignment} \
            -p output_file {output.variations_with_effects} \
            -p cell_entry_file {input.cell_entry} \
            -p reference_name {params.reference_name} \
            -p analysis_description "{params.analysis_description}" \
            -p mutation_identified_relative_to "{params.mutation_identified_relative_to}" \
            -p effects_calculated_relative_to "{params.effects_calculated_relative_to}" \
            -p min_mutation_count {params.min_mutation_count} """

        # Add optional effect reference parameters if specified
        if params.effect_reference_name:
            cmd += f" \\\n            -p effect_reference_file {input.effect_ref_file}"
            cmd += f" \\\n            -p effect_reference_name {params.effect_reference_name}"

        cmd += f" &> {log}"

        # Execute command
        shell(cmd)


rule plot_sequence_variation_effects:
    """Plot cell entry effects of naturally occurring sequence variation."""
    input:
        variations_with_effects="results/sequence_variation/{analysis}_sequence_variations_with_effects.csv",
        nb="notebooks/sequence_variation/plot_effect_of_sequence_variations.ipynb",
    output:
        chart_html="results/sequence_variation/{analysis}_sequence_variation_effects.html",
        nb="results/notebooks/plot_sequence_variation_effects_{analysis}.ipynb",
    params:
        strain_label=lambda wc: seq_var_config[wc.analysis]["strain_label"],
        analysis_description=lambda wc: seq_var_config[wc.analysis]["analysis_description"],
        mutation_identified_relative_to=lambda wc: seq_var_config[wc.analysis]["mutation_identified_relative_to"],
        effects_calculated_relative_to=lambda wc: seq_var_config[wc.analysis]["effects_calculated_relative_to"],
    log:
        "results/logs/plot_sequence_variation_effects_{analysis}.txt",
    conda:
        os.path.join(config["pipeline_path"], "environment.yml"),
    shell:
        """
        papermill {input.nb} {output.nb} \
            -p strain {params.strain_label} \
            -p variations_with_effects_file {input.variations_with_effects} \
            -p output_html {output.chart_html} \
            -p analysis_description "{params.analysis_description}" \
            -p mutation_identified_relative_to "{params.mutation_identified_relative_to}" \
            -p effects_calculated_relative_to "{params.effects_calculated_relative_to}" \
            &> {log}
        """


docs["Sequence variation analysis"] = {
    "Sequence variations with effects CSVs": {
        analysis: rules.find_variable_sites.output.variations_with_effects.format(analysis=analysis)
        for analysis in seq_var_analyses
    },
    "Interactive sequence variation plots": {
        analysis: rules.plot_sequence_variation_effects.output.chart_html.format(analysis=analysis)
        for analysis in seq_var_analyses
    },
    "Sequence variation analysis notebooks": {
        f"find_variable_sites_{analysis}": rules.find_variable_sites.output.nb.format(analysis=analysis)
        for analysis in seq_var_analyses
    } | {
        f"plot_sequence_variation_effects_{analysis}": rules.plot_sequence_variation_effects.output.nb.format(analysis=analysis)
        for analysis in seq_var_analyses
    },
}