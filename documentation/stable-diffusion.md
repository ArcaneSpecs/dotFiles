# To install on Arch Linux with AMD gpu
## Run first time:
```bash
git clone --depth 1 --recursive git@github.com:AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui
python3.11 -m venv venv
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.1
HSA_OVERRIDE_GFX_VERSION=11.0.0 python launch.py --precision full --no-half --opt-sub-quad-attention --lowvram --disable-nan-check
```

## After just run using 
```bash
./webui.sh
```
