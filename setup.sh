#!/bin/bash

################################################################################
## Erik's Arch Install Script                                                 ##
## To be used after the archinstall basic                                     ##
################################################################################

# Mandatory software
sudo pacman -S --needed --noconfirm dialog

################################################################################
### Questions                                                                ###
################################################################################

# Pick a AUR Helper
function AUR_HELPER() {
  clear
  echo "################################################################################"
  echo "### Which AUR Helper Do You Want To Install?                                 ###"
  echo "### 1)  YAY                                                                  ###"
  echo "### 2)  PARU (Takes a while to compile)                                      ###"
  echo "################################################################################"
  read case;

  case $case in
    1)
    ZB="yay"
    ;;
    2)
    ZB="paru"
    ;;
  esac
}

################################################################################
### Functions                                                                ###
################################################################################

# Install needed programs
function NEEDED_SOFTWARE() {
  sudo pacman -S --noconfirm --needed base-devel nano git neofetch wget rsync glances bashtop bpytop bat reflector lsd gtop ncdu duf btop inxi xorg-xhost fastfetch htop gtop
  yay -S --noconfirm --needed cpufetch pfetch
}

## Install AUR Helper
function AUR_SELECTION() {
  if [ ${ZB} = "yay" ]; then
    dialog --infobox "Installing The AUR Helper YAY." 3 34
    sleep 2
    clear
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --needed
    cd ..
    rm yay -R -f
  fi
  if [ ${ZB} = "paru" ]; then
    dialog --infobox "Installing The AUR Helper Paru." 3 35
    sleep 2
    clear
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm --needed
    cd ..
    rm paru -R -f
    sudo sed -i 's/#BottomUp/BottomUp/' /etc/paru.conf
  fi
}

# Addind some aliases to the BashRC file
function BASHRC_CONF() {
  dialog --infobox "Setting Up The BashRC Config File." 3 38
  sleep 3
  clear
  echo " " >> ~/.bashrc
  echo "# Check to see if neofetch is installed and if so display it" >> ~/.bashrc
  echo "if [ -f /usr/bin/neofetch ]; then clear & neofetch; fi" >> ~/.bashrc
  sed -i 's/alias/#alias'/g ~/.bashrc
  echo "# Setting up some aliases" >> ~/.bashrc
  echo "alias ls='lsd'" >> ~/.bashrc
  echo "alias cat='bat'" >> ~/.bashrc
  echo "alias fd='ncdu'" >> ~/.bashrc
  echo "alias netsp='bwm-ng'" >> ~/.bashrc
  echo "alias df='duf -hide special'" >> ~/.bashrc
  echo "alias sysmon='gtop'" >> ~/.bashrc
  echo "alias cpu='cpufetch'" >> ~/.bashrc
  echo "alias info='clear&&neofetch'" >> ~/.bashrc
  echo "alias info2='clear&&inxi -b'" >> ~/.bashrc
  echo "alias dbl='distrobox-list'" >> ~/.bashrc
  echo "alias dbe='clear && distrobox-enter'" >> ~/.bashrc
  echo "alias dbc='clear && distrobox-create'" >> ~/.bashrc
  echo "alias dbr='distrobox-rm'" >> ~/.bashrc
  echo "alias dbs='distrobox-stop -Y'" >> ~/.bashrc
  echo "alias dbu='distrobox-upgrade --all'" >> ~/.bashrc
  echo "alias ar-ref='clear && sudo reflector --country US --latest 20 --sort rate --verbose --save /etc/pacman.d/mirrorlist'" >> ~/.bashrc
  echo "alias db-up='clear && sudo apt update && sudo apt upgrade -y'" >> ~/.bashrc
  echo "alias fd-up='clear && sudo dnf update -y'" >> ~/.bashrc
  echo "alias fp-up='clear && flatpak update -y'" >> ~/.bashrc
  echo "alias info3='clear && fastfetch'" >> ~/.bashrc
  echo "alias info4='clear && pfetch'" >> ~/.bashrc
  echo "alias info-full='clear && neofetch && duf --hide special'" >> ~/.bashrc
  echo "alias sdh='sudo shutdown -h '" >> ~/.bashrc
  echo "alias sdr='sudo shutdown -r '" >> ~/.bashrc
  echo "alias compress='clear&&sudo btrfs filesystem defragment -c -r -v '" >> ~/.bashrc
  if [ ${ZB} = "yay" ]; then
    echo "alias ar-up='clear&&yay --noconfirm -Syu'" >> ~/.bashrc
  fi
  if [ ${ZB} = "paru" ]; then
    echo "alias ar-up='clear&&paru --noconfirm -Syu'" >> ~/.bashrc
  fi
}


################################################################################
### Main Program                                                             ###
################################################################################

AUR_HELPER
AUR_SELECTION
NEEDED_SOFTWARE
