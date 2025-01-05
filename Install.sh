# Exit the script if it's being run as root.
if [[ $(id -u) -eq 0 ]] ; then echo -e "\033[1;31mDon't run this script as root!\033[0m" ; exit 1 ; fi

# Update mirrors and install the virtualbox-guest-utils package.
sudo pacman -Sy --noconfirm --needed virtualbox-guest-utils
echo -e "\033[1;35mvirtualbox-guest-utils installed.\033[0m"

# Enable the virtualbox service 
sudo systemctl enable vboxservice.service
echo -e "\033[1;35mVirtualbox service enabled.\033[0m"

# Add the currently logged-in user to the vboxsf group.
sudo usermod -aG vboxsf $LOGNAME
echo -e "\033[1;36m$LOGNAME \033[1;35mhas been added to the vboxsf group.\033[0m"

# Enable Virtualbox client features.
VBoxClient-all

echo -e "\033[1;35mRunning /usr/bin/VBoxClient-all script to enable Virtualbox client features\033[0m"

# Exit script and show the guest additions were installed.
echo -e "\n\033[1;32mVirtual box guest additions installed! Please reboot your system.\033[0m"

exit 0