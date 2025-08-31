#!/bin/bash

export LD_LIBRARY_PATH=/home/patu/.conda/envs/comfyenv/lib/python3.12/site-packages/pymeshlab/lib:$LD_LIBRARY_PATH
source ~/.conda_init
conda activate comfyenv

# HSA_OVERRIDE_GFX_VERSION=11.0.0 python main.py --use-pytorch-cross-attention
python main.py
