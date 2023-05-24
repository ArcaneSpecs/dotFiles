#!/bin/bash

# Use this to Install dotFiles if this file is copied directly from git and not cloned first
# git clone --depth 1 git@github.com:ArcaneSpecs/dotFiles.git


# Install nix
# sh <(curl -L https://nixos.org/nix/install) --daemon

# Install git, make, gcc, g++, cmake
# nix-env -iA nixpkgs.git nixpkgs.neovim nixpkgs.cmake nixpkgs.gcc

# Install neovim from git
# git clone --depth 1 --recursive git@github.com:neovim/neovim.git github/neovim

# Move stuff to .config
cp -r .config/ ~/
cp .xinitrc ~/.xinitrc
cp .Xresources ~/.Xresources
cp .zshrc ~/




