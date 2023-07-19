#!/bin/bash

#SBATCH --job-name=star_processing
#SBATCH --output=star_processing_%A_%a.out
#SBATCH --error=star_processing_%A_%a.err
#SBATCH --time=5:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G
#SBATCH --partition=htc-el8

source $HOME/.bashrc
BASE_DIR="/g/kosinski/vmaurer/ribosomePaper/templates"
dirs=( $BASE_DIR/*/ )
dir=${dirs[$SLURM_ARRAY_TASK_ID-1]}
dir=${dir%*/}      # remove the trailing "/"

echo "Processing: $dir"
starout_path="$dir/coordinates.tsv"
TMdir="$dir"
scoresname="scores_template.em"

python3 callPeaks.py \
	--outpath $starout_path \
	--TMdir $TMdir \
	--scoresname $scoresname
