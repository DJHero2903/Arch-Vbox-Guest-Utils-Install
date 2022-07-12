LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
LIGHT_YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
N0_COLOUR='\033[0m'

# Exit the script if it's being run as root.
if [[ $(id -u) -eq 0 ]] ; then echo -e "${LIGHT_RED}Don't run this script as root!${NO_COLOUR}" ; exit 1 ; fi

# Update mirrors and install the virtualbox-guest-utils package.
sudo pacman -Sy --noconfirm --needed virtualbox-guest-utils
echo -e "${LIGHT_YELLOW}virtualbox-guest-utils installed.${NO_COLOUR}"

# Enable the virtualbox service 
sudo systemctl enable --now vboxservice.service
echo -e "${LIGHT_YELLOW}Virtualbox service enabled.${NO_COLOUR}"

# Add the virtualbox modules to the Linux Kernel.
sudo modprobe -a vboxguest vboxsf vboxvideo
echo -e "${LIGHT_YELLOW}Virtualbox kernal modules installed.${NO_COLOUR}"

# Add the currently logged-in user to the vboxsf group.
sudo usermod -aG vboxsf $LOGNAME
echo -e "${LIGHT_CYAN}$LOGNAME ${LIGHT_YELLOW}has been added to the vboxsf group.${NO_COLOUR}"

# Enable Virtualbox client features.
VBoxClient --clipboard
VBoxClient --draganddrop
VBoxClient --seamless
VBoxClient --checkhostversion
VBoxClient --vmsvga
echo -e "${LIGHT_YELLOW}clipboard, draganddrop, seamless, checkhostversion, vmsvga client features enabled.${NO_COLOUR}"

# Exit script and show the guest additions were installed.
echo -e "\n${LIGHT_GREEN}Virtual box guest additions installed! Please reboot your system.${NO_COLOUR}"

exit 1