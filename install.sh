#!/bin/bash

pushd "$(dirname "$0")/" > /dev/null

# Use this to Install dotFiles if this file is copied directly from git and not cloned first
# git clone --depth 1 git@github.com:ArcaneSpecs/dotFiles.git

# Install nix
# sh <(curl -L https://nixos.org/nix/install) --daemon

# Install git, make, gcc, g++, cmake
# nix-env -iA nixpkgs.git nixpkgs.neovim nixpkgs.cmake nixpkgs.gcc

# Install neovim from git
# git clone --depth 1 --recursive git@github.com:neovim/neovim.git github/neovim

# Configs 
cp -r .config/ ~/
cp .xinitrc ~/.xinitrc
cp .Xresources ~/.Xresources
cp .zshrc ~/
cp .bashrc ~/

# My programs
cp -r .local/ ~/

# System files
sudo cp locale.conf /etc/
sudo cp .config/nvidia/mkinitcpio.conf /etc/mkinitcpio.conf
sudo cp .config/nvidia/nvidia.conf /etc/modprobe.d/nvidia.conf
sudo cp .config/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf

popd > /dev/null

