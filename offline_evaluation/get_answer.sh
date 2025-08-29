#!/bin/bash

# Ensure the script exits if an error occurs
set -e

# Set default parameters
MODEL_NAME="openai/gpt-oss-20b"
DOWNLOAD_DIR="scratch"
OUTPUT_DIR="offline_outputs/gpt_oss_20b_outputs"
MAX_LINES=1500

# Define the list of dataset paths
DATASET_LIST=(
    "datasets/atomic_dataset_textonly.jsonl"
    "datasets/electro_dataset_textonly.jsonl"
    "datasets/mechanics_dataset_textonly.jsonl"
    "datasets/optics_dataset_textonly.jsonl"
    "datasets/quantum_dataset_textonly.jsonl"
    "datasets/statistics_dataset_textonly.jsonl"
)

# Ensure double quotes are properly closed and pass correct parameters
nohup python get_answer.py \
    --model_name "$MODEL_NAME" \
    --download_dir "$DOWNLOAD_DIR" \
    --output_dir "$OUTPUT_DIR" \
    --max_lines "$MAX_LINES" \
    --dataset_list "${DATASET_LIST[@]}" > get_answer.out 2>&1 &