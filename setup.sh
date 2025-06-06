#!/bin/bash

################################################################################
## Erik's Arch Install Script                                                 ##
## To be used after the archinstall basic                                     ##
################################################################################

# -----------------------------------------------------------------------------------------------------------
# Mandatory software
sudo pacman -S --needed --noconfirm dialog

# -----------------------------------------------------------------------------------------------------------
# Temp config copy
sudo cp config/pacman.conf /etc/pacman.conf
sudo cp config/nanorc /etc/nanorc
sudo cp config/10-vmmaxcount.conf /etc/sysctl.d/10-vmmaxcount.conf
sudo cp config/99-swappiness.conf /etc/sysctl.d/99-swappiness.conf
sudo pacman -Sy

clear
dialog --infobox "Welcome To Erik's Install Script." 3 38
sleep 3


################################################################################
### Questions                                                                ###
################################################################################

# -----------------------------------------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------------------------------------
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
  echo "### 09) Plasma                                                               ###"
  echo "### 10) i3                                                                   ###"
  echo "### 11) Sway                                                                 ###"
  echo "### 12) Hyprland                                                             ###"
  echo "###                                                                          ###"
  echo "### 99) None                                                                 ###"
  echo "################################################################################"
  read case;

  case $case in
    01)
    DESKTOPENV="gnome"
    clear
    echo "################################################################################"
    echo "### Do You Want To Install Gnome Extras?                                     ###"
    echo "### 1)  Yes                                                                  ###"
    echo "### 2)  No                                                                   ###"
    echo "################################################################################"
    read case;

    case $case in
      1)
      GNOME_EXTRA="yes"
      ;;
      2)
      GNOME_EXTRA="no"
      ;;
    esac
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
    09)
    DESKTOPENV="plasma"
    clear
    echo "################################################################################"
    echo "### Do You Want To Install KDE Plasma Extras?                                ###"
    echo "### 1)  Yes                                                                  ###"
    echo "### 2)  No                                                                   ###"
    echo "################################################################################"
    read case;

    case $case in
      1)
      PLASMA_EXTRA="yes"
      ;;
      2)
      PLASMA_EXTRA="no"
      ;;
    esac
    ;;
    10)
    DESKTOPENV="i3"
    ;;
    11)
    DESKTOPENV="sway"
    ;;
    12)
    DESKTOPENV="hyprland"
    ;;
    99)
    DESKTOPENV="none"
    ;;
    esac
  }

################################################################################
### Functions                                                                ###
################################################################################

# -----------------------------------------------------------------------------------------------------------
# Install needed programs
function NEEDED_SOFTWARE() {
  dialog --infobox "Installing needed CLI based software." 3 38
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed base-devel nano git neofetch wget rsync glances bashtop bpytop bat reflector lsd gtop ncdu duf btop inxi fastfetch htop gtop podman podman-docker podman-compose distrobox firefox hunspell hunspell-en_us man flatpak archlinux-wallpaper bwm-ng p7zip unrar cyme
  $ZB -S --noconfirm --needed cpufetch pfetch pacseek
  sudo pacman -S --noconfirm --needed xdg-user-dirs
  xdg-user-dirs-update
}

# -----------------------------------------------------------------------------------------------------------
# Install AUR Helper
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

# -----------------------------------------------------------------------------------------------------------
# Addind some aliases to the BashRC file
function BASHRC_CONF() {
  dialog --infobox "Setting Up The BashRC Config File." 3 38
  sleep 2
  clear
  echo " " >> ~/.bashrc
  sed -i 's/alias/#alias'/g ~/.bashrc
  echo "TERM=xterm-256color" >> ~/.bashrc
  echo "# Setting up some aliases" >> ~/.bashrc
  echo "alias ls='lsd'" >> ~/.bashrc
  echo "alias cat='bat'" >> ~/.bashrc
  echo "alias fd='ncdu'" >> ~/.bashrc
  echo "alias netsp='bwm-ng'" >> ~/.bashrc
  echo "alias df='duf -hide special'" >> ~/.bashrc
  echo "alias sysmon='gtop'" >> ~/.bashrc
  echo "alias cpu='cpufetch'" >> ~/.bashrc
  echo "alias info='clear && fastfetch -c paleofetch'" >> ~/.bashrc
  echo "alias info2='clear && inxi -b'" >> ~/.bashrc
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
  echo "alias info5='clear && neofetch'" >> ~/.bashrc
  echo "alias info-full='clear && fastfetch -c all'" >> ~/.bashrc
  echo "alias sdh='sudo shutdown -h '" >> ~/.bashrc
  echo "alias sdr='sudo shutdown -r '" >> ~/.bashrc
  echo "alias kconf='nano ~/.config/kitty/kitty.conf'" >> ~/.bashrc
  echo "alias 7zx='clear && 7z x -o~/Downloads'" >> ~/.bashrc
  echo "alias 7zm='clear && 7z a -m9 -r'" >> ~/.bashrc
  echo "alias lsl='lsd -l'" >> ~/.bashrc
  echo "alias compress='clear&&sudo btrfs filesystem defragment -c -r -v '" >> ~/.bashrc
  echo "alias usb='cyme -y'" >> ~/.bashrc
  if [ ${ZB} = "yay" ]; then
    echo "alias ar-up='clear&&yay --noconfirm -Syu'" >> ~/.bashrc
  fi
  if [ ${ZB} = "paru" ]; then
    echo "alias ar-up='clear&&paru --noconfirm -Syu'" >> ~/.bashrc
  fi
  if [ ${DESKTOPENV} = "hyprland" ]; then
    echo "alias conf='nano ~/.config/hypr/hyprland.conf'" >> ~/.bashrc
    echo "alias conf-bar='nano ~/.config/waybar/config'" >> ~/.bashrc
  fi
  if [ ${DESKTOPENV} = "sway" ]; then
    echo "alias conf='nano ~/.config/sway/config'" >> ~/.bashrc
  fi
  if [ ${DESKTOPENV} = "i3" ]; then
    echo "alias conf='nano ~/.config/i3/config'" >> ~/.bashrc
    echo "alias conf-bar='nano ~/.config/i3/i3status-config'" >> ~/.bashrc
  fi
}

# -----------------------------------------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------------------------------------
# Setting up Bluetooh Support
function BTSI() {
  dialog --infobox "Installing Bluetooth Files." 3 33
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed bluez bluez-libs bluez-utils bluez-tools bluez-cups blueberry
  sudo systemctl enable bluetooth.service
  sudo systemctl start bluetooh.service
}

# -----------------------------------------------------------------------------------------------------------
# Install Sound Themes
function INSTALL_SOUNDTHEME() {
  dialog --infobox "Installing Some Sound Themes." 3 33
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed deepin-sound-theme
  $ZB -S --noconfirm --needed sound-theme-smooth
}

# -----------------------------------------------------------------------------------------------------------
# Install Extra Fonts
function INSTALL_EXTRAFONTS() {
  dialog --infobox "Installing Some Extra System Fonts." 3 39
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed adobe-source-sans-pro-fonts cantarell-fonts noto-fonts terminus-font ttf-bitstream-vera ttf-dejavu ttf-droid ttf-inconsolata ttf-liberation ttf-roboto ttf-ubuntu-font-family awesome-terminal-fonts ttf-font-awesome ttf-hack ttf-ibm-plex nerd-fonts terminus-font
  $ZB -S --noconfirm --needed ttf-ms-fonts
}

# -----------------------------------------------------------------------------------------------------------
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
    sudo pacman -S --noconfirm --needed vulkan-mesa-layers lib32-vulkan-mesa-layers mesa-vdpau lib32-mesa-vdpau intel-compute-runtime intel-graphics-compiler intel-opencl-clang vulkan-icd-loader lib32-vulkan-icd-loader vkd3d lib32-vkd3d vulkan-swrast vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver rocm-opencl-runtime rocm-hip-libraries rocm-hip-runtime
    dialog --infobox "Thanks for supporting a free and open vendor." 3 49
    sleep 2
  fi
}

# -----------------------------------------------------------------------------------------------------------
# Gnome Desktop Install
function GNOME_DE() {
  dialog --infobox "Installing The Gnome Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed gnome nautilus-share gnome-browser-connector adw-gtk-theme gnome-tweaks
  $ZB -S --noconfirm --needed extension-manager
  gsettings set org.gnome.mutter check-alive-timeout 60000
  sudo systemctl enable gdm
  if [ ${GNOME_EXTRA} = "yes" ]; then
  sudo pacman -S --noconfirm --needed gnome-extra
  fi
}

# -----------------------------------------------------------------------------------------------------------
# Cinnamon Desktop Install
function CINNANON_DE() {
  dialog --infobox "Installing The Cinnamon Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings cinnamon gnome-disk-utility gnome-system-monitor gnome-calculator gpicview gedit variety onboard ark file-roller unrar p7zip nemo-fileroller nemo-share kitty kitty-terminfo kitty-shell-integration
  $ZB -S --noconfirm --needed gvfs-smb cinnamon-sounds mint-x-icons mint-themes mint-y-icons mint-artwork
  sudo systemctl enable lightdm
  gsettings set org.cinnamon.desktop.background picture-uri 'file:///usr/share/backgrounds/linuxmint-helena/Fresh.jpg'
  gsettings set org.cinnamon.desktop.background.slideshow image-source 'xml:///usr/share/gnome-background-properties/linuxmint-helena.xml'
  gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Aqua'
  gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-Y-Aqua'
  gsettings set org.cinnamon.theme name 'Mint-Y-Aqua'
  gsettings set org.gnome.desktop.interface gtk-theme 'Mint-Y-Aqua'
  gsettings set org.gnome.desktop.interface icon-theme 'Mint-Y-Aqua'
  mkdir -p ~/.config/kitty
  cp kitty/kitty.conf ~/.config/kitty/kitty.conf
}

# -----------------------------------------------------------------------------------------------------------
# LXQT Desktop Install
function LXQT_DE() {
  dialog --infobox "Installing The LQXT Desktop Environment" 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed lxqt gnome-disk-utility picom gnome-calculator gedit variety onboard ark file-roller unrar p7zip packagekit-qt5 breeze-icons breeze-gtk breeze sddm
  sudo systemctl enable sddm
}

# -----------------------------------------------------------------------------------------------------------
# MATE Desktop Install
function MATE_DE() {
  dialog --infobox "Installing The MATE Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed mate mate-extra gnome-disk-utility variety onboard ark file-roller unrar p7zip lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings gvfs-smb
  $ZB -S --noconfirm --needed mate-tweak brisk-menu mate-screensaver-hacks mugshot
  sudo systemctl enable lightdm
}

# -----------------------------------------------------------------------------------------------------------
# Budgie Desktop Install
function BUDGIE_DE() {
  dialog --infobox "Installing The Budgie Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed budgie-desktop budgie-extras gnome-system-monitor nautilus gnome-disk-utility gnome-control-center gnome-backgrounds gnome-calculator gedit variety onboard ark file-roller unrar p7zip gnome-tweaks lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings kitty kitty-terminfo kitty-shell-integration
  mkdir -p ~/.config/kitty
  cp kitty/kitty.conf ~/.config/kitty/kitty.conf
  sudo systemctl enable lightdm
}

# -----------------------------------------------------------------------------------------------------------
# Cutefish Desktop Install
function CUTEFISH_DE() {
  dialog --infobox "Installing The Cutefish Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed cutefish variety onboard ark file-roller unrar p7zip gnome-disk-utility eog lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings
  sudo systemctl enable lightdm
}

# -----------------------------------------------------------------------------------------------------------
# Deepin Desktop Install
function DEEPIN_DE() {
  dialog --infobox "Installing The Deepin Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed deepin gnome-disk-utility ark file-roller unrar p7zip onboard deepin-voice-note deepin-terminal deepin-screensaver-pp deepin-screen-recorder deepin-printer deepin-picker deepin-music deepin-movie deepin-font-manager deepin-editor deepin-draw deepin-device-formatter deepin-compressor deepin-community-wallpapers deepin-clone deepin-clipboard deepin-camera deepin-calculator deepin-boot-maker deepin-album
  sudo systemctl enable lightdm
}

# -----------------------------------------------------------------------------------------------------------
# XFCE Desktop Install
function XFCE_DE() {
  dialog --infobox "Installing The XFCE Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed xfce4 xfce4-goodies gnome-disk-utility ark file-roller unrar p7zip alacarte gnome-calculator picom variety libnma networkmanager networkmanager-openconnect networkmanager-openvpn networkmanager-pptp nm-connection-editor network-manager-applet onboard lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings gvfs-smb
  $ZB -S --noconfirm --needed xfce4-screensaver xfce4-panel-profiles-git mugshot xfce4-theme-switcher
  sudo mkdir -p /usr/share/xfce4-theme-switcher/themes
  $ZB -S --noconfirm --needed xts-windows10-theme xts-dark-theme xts-arcolinux-theme xts-windowsxp-theme xts-windows-server-2003-theme xts-windows95-theme # xts-macos-sierra-theme xts-macos-yosemite-theme xts-macos-big-sur-theme mcos-mjv-xfce-edition (currently osx version broken)
  cp kitty/kitty.conf ~/.config/kitty/kitty.conf
  sudo cp picom/picom.conf /etc/xdg/picom.conf
  sudo systemctl enable lightdm
}

# -----------------------------------------------------------------------------------------------------------
# Plasma Desktop Install
function PLASMA_DE() {
  dialog --infobox "Installing The KDE Plasma Desktop Environment." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed plasma gnome-disk-utility redshift plasma-wayland-protocols plasma-pass sddm dolphin konsole
  sudo systemctl enable sddm
  if [ ${PLASMA_EXTRA} = "yes" ]; then
  sudo pacman -S --needed --noconfirm kde-applications
  fi
}

# -----------------------------------------------------------------------------------------------------------
# i3 Window Manager Install
function i3_WM() {
  dialog --infobox "Installing The i3 Window Manager." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed i3 gnome-disk-utility onboard file-roller picom dmenu rofi nitrogen feh thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman xfce4-terminal xfce4-screenshooter papirus-icon-theme network-manager-applet arandr scrot lxappearance-gtk3 polkit-gnome galculator dunst ristretto pavucontrol lightdm lightdm-gtk-greeter lightdm-webkit2-greeter lightdm-gtk-greeter-settings gvfs-smb kitty mousepad kvantum simple-scan numlockx
  $ZB -S --noconfirm --needed mugshot i3exit pnmixer rofi-themes-collection-git
  mkdir -p ~/.config/dunst
  cp /etc/dunst/dunstrc ~/.config/dunst/
  mkdir -p ~/.config/i3
  cp i3/config ~/.config/i3/config
  cp i3/i3status-config ~/.config/i3/i3status-config
  mkdir -p ~/.config/kitty
  cp kitty/kitty.conf ~/.config/kitty/kitty.conf
  sudo cp picom/picom.conf /etc/xdg/picom.conf
  sudo systemctl enable lightdm
}

# -----------------------------------------------------------------------------------------------------------
# Sway Window Manager Install
function SWAY_WM() {
  dialog --infobox "Installing The Sway Window Manager." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed sway swaybg swayidle swaylock waybar nitrogen onboard ark file-roller unrar p7zip xfce4-terminal thunar thunar-archive-plugin thunar-media-tags-plugin network-manager-applet xfce4-screenshooter papirus-icon-theme arandr gnome-disk-utility polkit-gnome grim feh eog galculator sddm gvfs-smb kitty mousepad wofi nwg-look kitty gwenview
  $ZB -S --noconfirm --needed mugshot rofi-lbonn-wayland qt6ct-kde qt5-ct-kde sddm-conf-git wlogout
  mkdir -p ~/.config/sway
  cp sway/config ~/.config/sway/config
  mkdir -p ~/.config/waybar
  cp /etc/xdg/waybar/* ~/.config/waybar/
  mkdir -p ~/Pictures/shots
  mkdir -p ~/.config/kitty
  cp kitty/kitty.conf ~/.config/kitty/kitty.conf
  sudo systemctl enable sddm
}

# -----------------------------------------------------------------------------------------------------------
# Hyprland Window Manager Install
function HYPRLAND_DE(){
  dialog --infobox "Installing The Hyprland Window Manager." 3 40
  sleep 2
  clear
  sudo pacman -S --noconfirm --needed hyprland hypridle hyprlock xdg-desktop-portal-hyprland kitty dolphin gnome-disk-utility polkit sddm waybar breeze breeze-gtk breeze-icons kate nwg-look gwenview cool-retro-term pavucontrol okular grim polkit-gnome noto-fonts-emoji xdg-desktop-portal-gtk dunst thunar thunar-archive-plugin rofi-wayland archlinux-xdg-menu galculator ddcutil nwg-dock-hyprland network-manager-applet hyprpaper qt5ct qt6ct swww
  $ZB -S --noconfirm --needed mugshot sddm-conf-git waybar-module-pacman-updates-git wlogout wttrbar rofi-themes-collection-git hyprshot vdu_controls hyprland-qtutils waypaper
  mkdir -p ~/.config/hypr
  cp hyprland/hyprland.conf ~/.config/hypr/hyprland.conf
  cp hyprland/hyprlock.conf ~/.config/hypr/hyprlock.conf
  cp hyprland/hypridle.conf ~/.config/hypr/hypridle.conf
  cp hyprland/end.sh ~/.config/hypr/end.sh
  cp hyprland/walp.sh ~/.config/hypr/walp.sh
  chmod +x ~/.config/hypr/*.sh
  mkdir -p ~/.config/kitty
  cp kitty/kitty.conf ~/.config/kitty/kitty.conf
  mkdir -p ~/.config/waybar
  cp waybar/* ~/.config/waybar/
  mkdir -p ~/.config/waybar/scripts
  chmod +x ~/.config/waybar/scripts/*.sh
  cp waybar/scripts/* ~/.config/waybar/scripts/
  mkdir -p ~/.config/dunst
  cp /etc/dunst/dunstrc ~/.config/dunst/
  mkdir -p ~/.config/wlogout
  cp wlogout/* ~/.config/wlogout/
  mkdir -p ~/Pictures/Screenshots
  XDG_MENU_PREFIX=arch- kbuildsycoca6
  sudo systemctl enable sddm
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

if [ ${DESKTOPENV} = "plasma" ]; then
  PLASMA_DE
fi

if [ ${DESKTOPENV} = "i3" ]; then
  i3_WM
fi

if [ ${DESKTOPENV} = "sway" ]; then
  SWAY_WM
fi

if [ ${DESKTOPENV} = "hyprland" ]; then
  HYPRLAND_DE
fi

BASHRC_CONF
