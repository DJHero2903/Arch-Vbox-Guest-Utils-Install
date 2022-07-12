# Exit the script if it's being run as root.
if [[ $(id -u) -eq 0 ]] ; then echo "Don't run this script as root!" ; exit 1 ; fi

# Update mirrors and install the virtualbox-guest-utils package.
sudo pacman -Sy --noconfirm --needed virtualbox-guest-utils
echo "virtualbox-guest-utils installed."

# Enable the virtualbox service 
sudo systemctl enable --now vboxservice.service
echo "Virtualbox service enabled."

# Add the virtualbox modules to the Linux Kernel.
sudo modprobe -a vboxguest vboxsf vboxvideo
echo "Virtualbox kernal modules installed."

# Add $USER to the vboxsf group.
usermod -aG vboxsf $USER
echo "$USER has been added to the vboxsf group."

# Enable Virtualbox client features.
VBoxClient --clipboard
VBoxClient --draganddrop
VBoxClient --seamless
VBoxClient --checkhostversion
VBoxClient --vmsvga
echo "clipboard, draganddrop, seamless, checkhostversion, vmsvga client features enabled."

# Exit script and show the guest additions were installed.
echo "Virtual box guest additions installed! Please reboot your system."

exit 1