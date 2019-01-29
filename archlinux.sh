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
	echo -n "$USER password ? "
	passwd $USER
fi

usermod -aG wheel $USER
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

pacman -S --noconfirm $PACKAGES
