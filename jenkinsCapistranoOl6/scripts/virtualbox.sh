#!/bin/bash

yum install -y gcc kernel-uek-devel

set -x

echo "Installing the virtualbox guest additions"
VBOX_VERSION=$(cat /root/.vbox_version)
cd /tmp || exit 1
echo "Mounting VBoxGuestAdditions iso..."
mount -o loop /root/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
echo "Installing VBoxLinuxAdditions"
sh /mnt/VBoxLinuxAdditions.run
sleep 40
umount /mnt
sleep 40
rm -rf /root/VBoxGuestAdditions_*.iso
sleep 40
