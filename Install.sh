# Check is the script is being run as root, if not exit.
if [[ $(id -u) -ne 0 ]] ; then echo "Run this script as root!" ; exit 1 ; fi

# Update mirrors and install the virtualbox-guest-utils package.
sudo pacman -Sy --noconfirm virtualbox-guest-utils  &

# Enable the virtualbox service 
sudo systemctl enable --now vboxservice.service &

# Add the virtualbox modules to the Linux Kernel.
sudo modprobe -a vboxguest vboxsf vboxvideo &

# Invalidate the cached sudo credentials.
sudo -k

# Enable Virtualbox client features.
VBoxClient --clipboard &
VBoxClient --draganddrop &
VBoxClient --seamless &
VBoxClient --checkhostversion &
VBoxClient --vmsvga &

# Exit script and show the guest additions were installed.
echo "\n\nVirtual box guest additions installed!\nPlease reboot your system." &
exit 1
