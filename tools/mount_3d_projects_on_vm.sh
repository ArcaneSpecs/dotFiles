#!/bin/bash

mkdir -p /home/patu/3D/ScifiDEMO

# NOTE: Mounts into /home/patu/3D/ScifiDEMO on the vm
sudo mount -t cifs //pati.local/vault/3D/Projects/ScifiDEMO /home/patu/3D/ScifiDEMO -o rw,username=patu,file_mode=0777,dir_mode=0777

