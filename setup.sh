#!/bin/bash

################################################################################
## Erik's Arch Install Script                                                 ##
## To be used after the archinstall basic                                     ##
################################################################################

# Mandatory software
sudo pacman -S --needed --noconfirm dialog

# Temp config copy
sudo cp config/pacman.conf /etc/pacman.conf
sudo cp config/nanorc /etc/nanorc

clear
dialog --infobox "Welcome To Erik's Install Script." 3 38
sleep 3


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

# Samba filesharing
function SAMBA_SHARES() {
  clear
  echo "################################################################################"
  echo "### Do you want SAMBA network sharing installed?                             ###"
  echo "### 1)  Yes                                                                  ###"
  echo "### 2)  No                                                                   ###"
  echo "################################################################################"
  read case;

  case $case in
    1)
    SAMBA_SH="yes"
    ;;
    2)
    SAMBA_SH="no"
    ;;
  esac
}

# Printer Support
function PRINTER_SUPPORT() {
  clear
  echo "################################################################################"
  echo "### Do You Want Printer Support?                                             ###"
  echo "### 1)  Yes                                                                  ###"
  echo "### 2)  No                                                                   ###"
  echo "################################################################################"
  read case;

  case $case in
    1)
    PSUPPORT="yes"
    clear
    echo "################################################################################"
    echo "### Do You Want HP Printer Support?                                          ###"
    echo "### 1)  Yes                                                                  ###"
    echo "### 2)  No                                                                   ###"
    echo "################################################################################"
    read case;
    case $case in
      1)
      HP_PRINT="yes"
      ;;
      2)
      HP_PRINT="no"
      ;;
    esac
    clear
    echo "################################################################################"
    echo "### Do You Want Epson Printer Support?                                       ###"
    echo "### 1)  Yes                                                                  ###"
    echo "### 2)  No                                                                   ###"
    echo "################################################################################"
    read case;
    case $case in
      1)
      EP_PRINT="yes"
      ;;
      2)
      EP_PRINT="no"
      ;;
    esac
    ;;
    2)
    PSUPPORT="no"
    ;;
  esac
}

# Bluetooth Support
function B_SUPPORT() {
  clear
  echo "################################################################################"
  echo "### Do You Want Bluetooth Support?                                           ###"
  echo "### 1)  Yes                                                                  ###"
  echo "### 2)  No                                                                   ###"
  echo "################################################################################"
  read case;

  case $case in
    1)
    BT_SUPPORT="yes"
    ;;
    2)
    BT_SUPPORT="no"
    ;;
  esac
}

################################################################################
### Functions                                                                ###
################################################################################

# Install needed programs
function NEEDED_SOFTWARE() {
  dialog --infobox "Installing needed CLI based software." 3 38
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed base-devel nano git neofetch wget rsync glances bashtop bpytop bat reflector lsd gtop ncdu duf btop inxi xorg-xhost fastfetch htop gtop podman podman-docker podman-compose distrobox
  $ZB -S --noconfirm --needed cpufetch pfetch
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
  sleep 2
  clear
  echo " " >> ~/.bashrc
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

# Samba Shares Installation
function SAMBA_INSTALL() {
  dialog --infobox "Setting Up The Samba Shares." 3 32
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed samba gvfs-smb avahi nss-mdns
  sudo wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf
  sudo sed -i -r 's/MYGROUP/WORKGROUP/' /etc/samba/smb.conf
  sudo sed -i -r "s/Samba Server/$HOSTNAME/" /etc/samba/smb.conf
  sudo systemctl enable smb.service
  sudo systemctl start smb.service
  sudo systemctl enable nmb.service
  sudo systemctl start nmb.service
##Access samba share windows
  sudo systemctl enable avahi-daemon.service
  sudo systemctl start avahi-daemon.service
  sudo sed -i 's/dns/mdns dns wins/g' /etc/nsswitch.conf
##Set-up user sharing (disable this section if you dont want user shares)
  sudo mkdir -p /var/lib/samba/usershares
  sudo groupadd -r sambashare
  sudo chown root:sambashare /var/lib/samba/usershares
  sudo chmod 1770 /var/lib/samba/usershares
  sudo sed -i -r '/\[global\]/a\username path = /var/lib/samba/usershares\nusershare max shares = 100\nusershare allow guests = yes\nusershare owner only = yes' /etc/samba/smb.conf
  sudo gpasswd sambashare -a $(whoami)
}

# Setup Printing
function PRINTERSETUP() {
  dialog --infobox "Installing Printer Subsystem." 3 33
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed cups cups-pdf ghostscript gsfonts gutenprint gtk3-print-backends libcups system-config-printer foomatic-db foomatic-db-ppds foomatic-db-gutenprint-ppds foomatic-db-engine foomatic-db-nonfree foomatic-db-nonfree-ppds
  if [ ${HP_PRINT} = "yes" ]; then
    sudo pacman -S --noconfirm --needed hplip
  fi
  if [ ${EP_PRINT} = "yes" ]; then
    $ZB -S --noconfirm --needed epson-inkjet-printer-escpr
  fi
  sudo systemctl enable cups.service
}

# Setting Up Bluetooth Support
function BTSETUP() {
  dialog --infobox "Installing Bluetooth Files." 3 31
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed bluez bluez-libs bluez-utils bluez-plugins blueberry bluez-tools bluez-cups
  sudo systemctl enable bluetooth.service
  sudo systemctl start bluetooth.service
  sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
}

################################################################################
### Main Program                                                             ###
################################################################################

AUR_HELPER
SAMBA_SHARES
PRINTER_SUPPORT
B_SUPPORT

echo "Samba:"$SAMBA_SH  "Printer:"$PSUPPORT "HP:"$HP_PRINT  "Epson:"$EP_PRINT  "Bluetooth:"$BT_SUPPORT
sleep 60

AUR_SELECTION
NEEDED_SOFTWARE

if [ ${SAMBA_SH} = "yes" ]; then
  SAMBA_INSTALL
fi
if [ {$PSUPPORT} = "yes" ]; then
  PRINTERSETUP
fi
if [ {$BT_SUPPORT} = "yes" ]; then
  BTSETUP
fi

BASHRC_CONF
