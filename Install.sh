# Check is the script is being run as root, if so exit.
if [[ $(id -u) == 0 ]] ; then echo "Don't run this script as root.\nExiting." ; exit 1 ; fi

# Update mirrors and install the virtualbox-guest-utils package.
sudo pacman -Sy --noconfirm virtualbox-guest-utils  &

# Enable the virtualbox service 
sudo systemctl enable --now vboxservice.service &

# Add the virtualbox modules to the Linux Kernel.
sudo modprobe -a vboxguest vboxsf vboxvideo &

# Enable Virtualbox client features.
VBoxClient --clipboard &
VBoxClient --draganddrop &
VBoxClient --seamless &
VBoxClient --checkhostversion &
VBoxClient --vmsvga &

# Exit script and show the guest additions were installed.
echo "\n\nVirtual box guest additions installed!\nPlease reboot your system."
exit 1
