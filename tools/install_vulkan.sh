#!/bin/bash

yes | sudo pacman -S base-devel glm cmake libpng wayland libpciaccess libx11 libxpresent    \
libxcb xcb-util libxrandr xcb-util-keysyms xcb-util-wm python git lz4 zstd python-distlib   \
qt5-base wayland-protocols ninja

yes | sudo pacman -S qt5-base libxcb libxinerama

mkdir -p ~/vulkan
cd ~/vulkan

tar xf $HOME/Downloads/vulkansdk-linux-x86_64-1.*.*.*.tar.gz

source ~/vulkan/1.*.*.*/setup-env.sh

sudo cp -r $VULKAN_SDK/include/vulkan/ /usr/local/include/

sudo cp -P $VULKAN_SDK/lib/libvulkan.so* /usr/local/lib/

sudo cp $VULKAN_SDK/lib/libVkLayer_*.so /usr/local/lib/

sudo mkdir -p /usr/local/share/vulkan/explicit_layer.d

sudo cp $VULKAN_SDK/etc/vulkan/explicit_layer.d/VkLayer_*.json /usr/local/share/vulkan/explicit_layer.d

