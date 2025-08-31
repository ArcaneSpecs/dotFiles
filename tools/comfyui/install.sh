#!/bin/bash

rm -rf venv
python -m venv venv
if [ $? -eq 0 ]; then
    source venv/bin/activate
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.2.4
    pip install -r requirements.txt
fi

