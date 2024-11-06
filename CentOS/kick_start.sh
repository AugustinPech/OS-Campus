#!/usr/bin/env bash
 
## Define variables
MEM_SIZE=1024       # Memory setting in MiB
VCPUS=1             # CPU Cores count
BRIDGE_NETWORK=virbr0  # Name of the Bridge Network
OS_VARIANT="rhel9.0" # virt-install --osinfo list
ISO_FILE="/home/augustin/Downloads/CentOS-Stream-9-latest-x86_64-dvd1.iso" # Path to ISO file
VM_NAME="centos" # The VM name
DISK_SIZE=20 # Disk size in GB
 

VM_LIST=$(virsh list --all)

if [[ ${VM_LIST} =~ ${VM_NAME} ]]; then
	virsh destroy ${VM_NAME}
	virsh undefine --domain ${VM_NAME} --nvram
fi

virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --location ${ISO_FILE} \
     --disk size=${DISK_SIZE}  \
     --graphics=none \
     --os-variant=${OS_VARIANT} \
     --console pty,target_type=serial \
     --initrd-inject centos9-ks.cfg \
     --extra-args "inst.ks=file:/centos9-ks.cfg console=tty0 console=ttyS0,115200n8"

