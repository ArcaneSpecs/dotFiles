#!/bin/bash

# NOTE: Run in conda envs and comfyui root dir if we get error loading this ↓
# find . \( -name "libhiprtc.so" -o -name "libamdhip64.so" \) -exec patchelf --clear-execstack {} \;

rm -rf venv
python -m venv venv
if [ $? -eq 0 ]; then
    source venv/bin/activate
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.2.4
    pip install -r requirements.txt
fi

