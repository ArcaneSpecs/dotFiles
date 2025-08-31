#!/bin/bash


# NOTE: For libstdc++.so.6 error:
# cd /home/my_user/.conda/envs/comfyenv/bin/../lib/
# NOTE: backup the old libstdc++.so.6 if something goes wrong
# mv libstdc++.so.6 libstdc++.so.6_old
# ln -s /usr/lib/libstdc++.so.6 libstdc++.so.6

# NOTE: Run in conda envs and comfyui root dir if we get error loading this ↓
# find . \( -name "libhiprtc.so" -o -name "libamdhip64.so" \) -exec patchelf --clear-execstack {} \;

# rm -rf venv
# python -m venv venv

conda create -n comfyenv python=3.12
conda activate comfyenv

if [ $? -eq 0 ]; then
    # source venv/bin/activate
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.2.4
    pip install -r requirements.txt
fi

