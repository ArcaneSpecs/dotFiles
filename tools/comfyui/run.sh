#!/bin/bash
export LD_LIBRARY_PATH=/home/patu/github/ComfyUI/venv/lib/python3.13/site-packages/pymeshlab/lib/:$LD_LIBRARY_PATH
source venv/bin/activate

HSA_OVERRIDE_GFX_VERSION=11.0.0 python main.py --use-pytorch-cross-attention

