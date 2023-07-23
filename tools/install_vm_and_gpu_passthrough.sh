#!/bin/bash

# https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF

# Install virt manager and qemu
sudo pacman -S libvirt virt-manager qemu \
dnsmasq swtpm ebtables iptables-nft edk2-ovmf spice-vdagent

spice-vdagent &

sudo systemctl enable libvirtd.service --now
# sudo systemctl status libvirtd.service
sudo systemctl enable virtlogd.service --now
sudo virsh net-autostart default
sudo virsh net-start default

# Download windows 11 ISO
wget https://software.download.prss.microsoft.com/dbazure/Win11_22H2_English_x64v2.iso?t=b620b4ed-1bf1-459f-8941-9cf8d7fb0d0d&e=1690234277&h=36bd7bca068c5a7af30bcd86d3d9a2fd69c59e3b29123be400694aaf0fd2426b -P ~/Downloads/Win11.iso


# Check IOMMU
sudo dmesg | grep -i -e DMAR -e IOMMU

# Find the card we want to passthrough
shopt -s nullglob
for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;

# This line to /etc/default/grub
#GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet vfio-pci.ids= " 



