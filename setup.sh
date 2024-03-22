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
function BTS() {
  clear
  echo "################################################################################"
  echo "### Do You Want Bluetooth Support?                                           ###"
  echo "### 1)  Yes                                                                  ###"
  echo "### 2)  No                                                                   ###"
  echo "################################################################################"
  read case;

  case $case in
    1)
    BTV="yes"
    ;;
    2)
    BTV="no"
    ;;
  esac
}

# Extra Sound Themes
function SOUNDTHEME_SUPPORT() {
  clear
  echo "################################################################################"
  echo "### Do You Want To Install Extra Sound Themes?                               ###"
  echo "### 1)  Yes                                                                  ###"
  echo "### 2)  No                                                                   ###"
  echo "################################################################################"
  read case;

  case $case in
    1)
    SND_THEME="yes"
    ;;
    2)
    SND_THEME="no"
    ;;
  esac
}

# Extra System Fonts
function EXTRA_FONTS() {
  clear
  echo "################################################################################"
  echo "### Do You Want To Install Extra System Font?                                ###"
  echo "### 1)  Yes                                                                  ###"
  echo "### 2)  No                                                                   ###"
  echo "################################################################################"
  read case;

  case $case in
    1)
    EXFONTS="yes"
    ;;
    2)
    EXFONTS="no"
    ;;
  esac
}

# Desktop Enviroment/Window Manager Install
function DEWM() {
  clear
  echo "################################################################################"
  echo "### What Desktop Enviroment or Window Manager Do You Want To Install?        ###"
  echo "###--------------------------------------------------------------------------###"
  echo "### 01) Gnome                                                                ###"
  echo "### 02) Cinnamon                                                             ###"
  echo "### 03) LXQT                                                                 ###"
  echo "### 04) MATE                                                                 ###"
  echo "### 05) Budgie                                                               ###"
  echo "### 06) Cutefish (currently buggy)                                           ###"
  echo "### 07) Deepin                                                               ###"
  echo "### 08) XFCE                                                                 ###"
  echo "################################################################################"
  read case;

  case $case in
    01)
    DESKTOPENV="gnome"
    ;;
    02)
    DESKTOPENV="cinnamon"
    ;;
    03)
    DESKTOPENV="lxqt"
    ;;
    04)
    DESKTOPENV="mate"
    ;;
    05)
    DESKTOPENV="budgie"
    ;;
    06)
    DESKTOPENV="cutefish"
    ;;
    07)
    DESKTOPENV="deepin"
    ;;
    08)
    DESKTOPENV="xfce"
    ;;
    99)
    DESKTOPENV="none"
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

# Setting up Bluetooh Support
function BTSI() {
  dialog --infobox "Installing Bluetooth Files." 3 33
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed bluez bluez-libs bluez-utils bluez-tools bluez-cups blueberry
  sudo systemctl enable bluetooth.service
  sudo systemctl start bluetooh.service
}

# Install Sound Themes
function INSTALL_SOUNDTHEME() {
  dialog --infobox "Installing Some Sound Themes." 3 33
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed deepin-sound-theme
  $ZB -S --noconfirm --needed sound-theme-smooth
}

# Install Extra Fonts
function INSTALL_EXTRAFONTS() {
  dialog --infobox "Installing Some Extra System Fonts." 3 39
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed adobe-source-sans-pro-fonts cantarell-fonts noto-fonts terminus-font ttf-bitstream-vera ttf-dejavu ttf-droid ttf-inconsolata ttf-liberation ttf-roboto ttf-ubuntu-font-family awesome-terminal-fonts ttf-font-awesome ttf-hack ttf-ibm-plex nerd-fonts terminus-font
  $ZB -S --noconfirm --needed ttf-ms-fonts siji-git ttf-font-awesome apple-fonts
}

# Check What Video Card Installed
function VC_INSTALL() {
  if [[ $(lspci -k | grep VGA | grep -i nvidia) ]]; then
    dialog --infobox "Installing nVidia Video Drivers." 3 36
    sleep 2
    clear
    sudo pacman -S --noconfirm --needed nvidia nvidia-cg-toolkit nvidia-settings nvidia-utils lib32-nvidia-cg-toolkit lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia cuda ffnvcodec-headers lib32-libvdpau libxnvctrl pycuda-headers python-pycuda
    sudo pacman -R --noconfirm xf86-video-nouveau
  fi

  if [[ $(lspci -k | grep VGA | grep -i amd) ]]; then
    dialog --infobox "Installing AMD Video Drivers." 3 33
    sleep 2
    clear
    sudo pacman -S --noconfirm --needed opencl-mesa lib32-opencl-mesa vulkan-mesa-layers lib32-vulkan-mesa-layers mesa-vdpau lib32-mesa-vdpau intel-compute-runtime intel-graphics-compiler intel-opencl-clang vulkan-icd-loader lib32-vulkan-icd-loader vkd3d lib32-vkd3d vulkan-swrast vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver rocm-opencl-runtime rocm-hip-libraries rocm-hip-runtime
    dialog --infobox "Thanks for supporting a free and open vendor." 3 49
    sleep 2
  fi
}

# Gnome Desktop Install
function GNOME_DE() {
  dialog --infobox "Installing The Gnome Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed gnome gnome-extra nautilus-share gnome-browser-connector
  $ZB -S --noconfirm --needed extension-manager
  sudo systemctl enable gdm
}

# Cinnamon Desktop Install
function CINNANON_DE() {
  dialog --infobox "Installing The Cinnamon Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings cinnamon gnome-disk-utility gnome-system-monitor gnome-calculator gpicview gedit variety onboard ark file-roller unrar p7zip nemo-fileroller nemo-share kitty kitty-terminfo kitty-shell-integration
  $ZB -S --noconfirm --needed gvfs-smb cinnamon-sounds mint-x-icon mint-themes mint-y-icons mint-artwork
  sudo systemctl enable lightdm
  gsettings set org.cinnamon.desktop.background picture-uri 'file:///usr/share/backgrounds/linuxmint-helena/Fresh.jpg'
  gsettings set org.cinnamon.desktop.background.slideshow image-source 'xml:///usr/share/gnome-background-properties/linuxmint-helena.xml'
  gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Aqua'
  gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-Y-Aqua'
  gsettings set org.cinnamon.theme name 'Mint-Y-Aqua'
  gsettings set org.gnome.desktop.interface gtk-theme 'Mint-Y-Aqua'
  gsettings set org.gnome.desktop.interface icon-theme 'Mint-Y-Aqua'
}

# LXQT Desktop Install
function LXQT_DE() {
  dialog --infobox "Installing The LQXT Desktop Environment" 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed lxqt gnome-disk-utility picom gnome-calculator gedit variety onboard ark file-roller unrar p7zip packagekit-qt5 breeze-icons breeze-gtk breeze sddm
  sudo systemctl enable sddm
}

# MATE Desktop Install
function MATE_DE() {
  dialog --infobox "Installing The MATE Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed mate mate-extra gnome-disk-utility variety onboard ark file-roller unrar p7zip lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings
  $ZB -S --noconfirm --needed mate-tweak brisk-menu mate-screensaver-hacks mugshot
  sudo systemctl enable lightdm
}

# Budgie Desktop Install
function BUDGIE_DE() {
  dialog --infobox "Installing The Budgie Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed budgie-desktop budgie-extras gnome-system-monitor nautilus gnome-disk-utility gnome-control-center gnome-backgrounds gnome-calculator gedit variety onboard ark file-roller unrar p7zip gnome-tweaks lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings kitty kitty-terminfo kitty-shell-integration
  sudo systemctl enable lightdm
}

# Cutefish Desktop Install
function CUTEFISH_DE() {
  dialog --infobox "Installing The Cutefish Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed cutefish variety onboard ark file-roller unrar p7zip gnome-disk-utility eog lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings
  sudo systemctl enable lightdm
}

# Deepin Desktop Install
function DEEPIN_DE() {
  dialog --infobox "Installing The Deepin Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed deepin gnome-disk-utility ark file-roller unrar p7zip onboard deepin-voice-note deepin-terminal deepin-screensaver-pp deepin-screen-recorder deepin-printer deepin-picker deepin-music deepin-movie deepin-font-manager deepin-editor deepin-draw deepin-device-formatter deepin-compressor deepin-community-wallpapers deepin-clone deepin-clipboard deepin-camera deepin-calculator deepin-boot-maker deepin-album
  sudo systemctl enable lightdm
}

# XFCE Desktop Install
function XFCE_DE() {
  dialog --infobox "Installing The XFCE Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed xfce4 xfce4-goodies gnome-disk-utility ark file-roller unrar p7zip alacarte gnome-calculator picom variety libnma networkmanager networkmanager-openconnect networkmanager-openvpn networkmanager-pptp nm-connection-editor network-manager-applet onboard lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings gvfs-smb
  $ZB -S --noconfirm --needed xfce4-screensaver xfce4-panel-profiles-git mugshot solarized-dark-themes gtk-theme-glossyblack mcos-mjv-xfce-edition xfce4-theme-switcher xts-windows10-theme xts-dark-theme xts-arcolinux-theme xts-windowsxp-theme xts-windows-server-2003-theme xts-windows95-theme xts-macos-sierra-theme xts-macos-yosemite-theme xts-macos-big-sur-theme
  sudo systemctl enable lightdm
}

################################################################################
### Main Program                                                             ###
################################################################################

AUR_HELPER
SAMBA_SHARES
PRINTER_SUPPORT
BTS
SOUNDTHEME_SUPPORT
EXTRA_FONTS
DEWM

AUR_SELECTION
NEEDED_SOFTWARE
VC_INSTALL

if [ ${SAMBA_SH} = "yes" ]; then
  SAMBA_INSTALL
fi

if [ ${PSUPPORT} = "yes" ]; then
  PRINTERSETUP
fi

if [ ${BTV} = "yes" ]; then
  BTSI
fi

if [ ${SND_THEME} = "yes" ]; then
  INSTALL_SOUNDTHEME
fi

if [ ${EXFONTS} = "yes" ]; then
  INSTALL_EXTRAFONTS
fi

if [ ${DESKTOPENV} = "gnome" ]; then
  GNOME_DE
fi

if [ ${DESKTOPENV} = "cinnamon" ]; then
  CINNANON_DE
fi

if [ ${DESKTOPENV} = "lxqt" ]; then
  LXQT_DE
fi

if [ ${DESKTOPENV} = "mate" ]; then
  MATE_DE
fi

if [ ${DESKTOPENV} = "budgie" ]; then
  BUDGIE_DE
fi

if [ ${DESKTOPENV} = "cutefish" ]; then
  CUTEFISH_DE
fi

if [ ${DESKTOPENV} = "deepin" ]; then
  DEEPIN_DE
fi

if [ ${DESKTOPENV} = "xfce" ]; then
  XFCE_DE
fi

BASHRC_CONF
