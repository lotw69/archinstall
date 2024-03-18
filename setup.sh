#!/bin/bash

################################################################################
## Erik's Arch Install Script                                                 ##
## To be used after the archinstall basic                                     ##
################################################################################

# Mandatory software
sudo pacman -S --needed --noconfirm dialog

# Questions

## Pick a AUR Helper
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


# Functions

## Install needed programs
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
