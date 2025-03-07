# Pseudovirus deep mutational scanning of RSV Long F Protein 

## Organization of this repo

### `dms-vep-pipeline-3` submodule

Most of the analysis is done by the [dms-vep-pipeline-3](https://github.com/dms-vep/dms-vep-pipeline-3), which was added as a [git submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to this pipeline via:

    git submodule add https://github.com/dms-vep/dms-vep-pipeline-3

This added the file [.gitmodules](.gitmodules) and the submodule [dms-vep-pipeline-3](https://github.com/dms-vep/dms-vep-pipeline-3), which was then committed to the repo.
Note that if you want a specific commit or tag of [dms-vep-pipeline-3](https://github.com/dms-vep/dms-vep-pipeline-3) or to update to a new commit, follow the [steps here](https://stackoverflow.com/a/10916398), basically:

    cd dms-vep-pipeline-3
    git checkout <commit>

and then `cd ../` back to the top-level directory, and add and commit the updated `dms-vep-pipeline-3` submodule.
You can also make changes to the [dms-vep-pipeline-3](https://github.com/dms-vep/dms-vep-pipeline-3) that you commit back to that repo.

### Code and configuration
The [snakemake](https://snakemake.readthedocs.io/) pipeline itself is run by `dms-vep-pipeline-3/Snakefile` which reads its configuration from [config.yaml](config.yaml).
The [conda](https://docs.conda.io/) environment used by the pipeline is that specified in the `environment.yml` file in [dms-vep-pipeline-3](https://github.com/dms-vep/dms-vep-pipeline-3).

### Data
Input data utilized by the pipeline are located in [./data/](data). 

### Results and documentation
The results of running the pipeline are placed in [./results/](results).
Due to space, only some results are tracked. For those that are not, see the [.gitignore](.gitignore) document.

The pipeline builds HTML documentation for the pipeline in [./docs/](docs). These docs are rendered for viewing at [https://dms-vep.org/RSV_Long_F_DMS/](https://dms-vep.org/RSV_Long_F_DMS).


## Running the pipeline (dry-run)
To do a test run of the pipeline you can execute the following command
    snakemake -n -s dms-vep-pipeline-3/Snakefile --rerun-incomplete

## Running the pipeline
To run the pipeline, build the conda environment `dms-vep-pipeline-3` in the `environment.yml` file of [dms-vep-pipeline-3](https://github.com/dms-vep/dms-vep-pipeline-3), activate it, and run [snakemake](https://snakemake.readthedocs.io/), such as:

    conda activate dms-vep-pipeline-3
    snakemake -j 16 --software-deployment-method conda -s dms-vep-pipeline-3/Snakefile

To run on the Hutch cluster via [slurm](https://slurm.schedmd.com/), you can run the file [run_Hutch_cluster.bash](run_Hutch_cluster.bash):

    sbatch run_Hutch_cluster.bash
