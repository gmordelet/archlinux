#!/bin/sh

USER=gregoire
PACKAGES="
openssh
sshpass
sudo
ansible
git
"

id -u $USER 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	useradd -m $USER
fi

usermod -aG wheel $USER
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

pacman -S --needed --noconfirm $PACKAGES
systemctl start sshd

SSHDIR="/home/$USER/.ssh"
mkdir $SSHDIR
chown gregoire $SSHDIR
ssh-keygen -f $SSHDIR/id_rsa -t rsa -N ''
chown $USER $SSHDIR/*

