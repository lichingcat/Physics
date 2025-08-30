#!/bin/bash

# Ensure the script exits if an error occurs
set -e

# Set default parameters
MODEL_NAME="openai/gpt-oss-120b"
DOWNLOAD_DIR="/home/ray/.cache/vllm-checkpoints"
OUTPUT_DIR="offline_outputs/gpt_oss_120b_outputs"
MAX_LINES=1500
TP=8

# Define the list of dataset paths
DATASET_LIST=(
    "PHYSICS/PHYSICS-textonly/atomic_dataset_textonly.jsonl"
    "PHYSICS/PHYSICS-textonly/electro_dataset_textonly.jsonl"
    "PHYSICS/PHYSICS-textonly/mechanics_dataset_textonly.jsonl"
    "PHYSICS/PHYSICS-textonly/optics_dataset_textonly.jsonl"
    "PHYSICS/PHYSICS-textonly/quantum_dataset_textonly.jsonl"
    "PHYSICS/PHYSICS-textonly/statistics_dataset_textonly.jsonl"
)

mkdir -p $DOWNLOAD_DIR

# Ensure double quotes are properly closed and pass correct parameters
OMP_NUM_THREAD=8 VLLM_ATTENTION_BACKEND=TRITON_ATTN_VLLM_V1 python offline_evaluation/get_answer.py \
    --model_name "$MODEL_NAME" \
    --download_dir "$DOWNLOAD_DIR" \
    --output_dir "$OUTPUT_DIR" \
    --max_lines "$MAX_LINES" \
    --dataset_list "${DATASET_LIST[@]}" \
    --tp "$TP"
    # --dataset_list "${DATASET_LIST[@]}" > get_answer.out 2>&1