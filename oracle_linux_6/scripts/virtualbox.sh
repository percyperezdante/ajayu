echo "Installing the virtualbox guest additions"
VBOX_VERSION=$(cat /home/ajayu/.vbox_version)
cd /tmp || exit 1
echo "Mounting VBoxGuestAdditions iso..."
mount -o loop /home/ajayu/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
echo "Installing VBoxLinuxAdditions"
sh /mnt/VBoxLinuxAdditions.run
sleep 40
umount /mnt
sleep 40
rm -rf /home/ajayu/VBoxGuestAdditions_*.iso
sleep 40
