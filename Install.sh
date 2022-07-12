# Exit the script if it's being run as root.
if [[ $(id -u) -eq 0 ]] ; then echo -e "\033[1;31mDon't run this script as root!\033[0m" ; exit 1 ; fi

# Update mirrors and install the virtualbox-guest-utils package.
sudo pacman -Sy --noconfirm --needed virtualbox-guest-utils
echo -e "\033[1;33mvirtualbox-guest-utils installed.\033[0m"

# Enable the virtualbox service 
sudo systemctl enable --now vboxservice.service
echo -e "\033[1;33mVirtualbox service enabled.\033[0m"

# Add the virtualbox modules to the Linux Kernel.
sudo modprobe -a vboxguest vboxsf vboxvideo
echo -e "\033[1;33mVirtualbox kernal modules installed.\033[0m"

# Add the currently logged-in user to the vboxsf group.
sudo usermod -aG vboxsf $LOGNAME
echo -e "\033[1;36m$LOGNAME \033[1;33mhas been added to the vboxsf group.\033[0m"

# Enable Virtualbox client features.
VBoxClient --clipboard
VBoxClient --draganddrop
VBoxClient --seamless
VBoxClient --checkhostversion
VBoxClient --vmsvga
echo -e "\033[1;33mclipboard, draganddrop, seamless, checkhostversion, vmsvga client features enabled.\033[0m"

# Exit script and show the guest additions were installed.
echo -e "\n\033[1;32mVirtual box guest additions installed! Please reboot your system.\033[0m"

exit 1