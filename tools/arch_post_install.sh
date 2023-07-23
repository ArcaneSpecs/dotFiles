#!/bin/bash

pushd "$(dirname "$0")/" > /dev/null

# Update system
sudo pacman -Syu --noconfirm

# Change shell to zsh
sudo chsh -s /bin/zsh

sudo pacman -S --needed --noconfirm base-devel
sudo pacman -S --noconfirm git wget tar zip unzip sddm pcmanfm nodejs kitty locate 
sudo pacman -S --noconfirm arc-gtk-theme arc-icon-theme breeze-icons

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

mkdir -p ~/github
git clone --depth 1 --recursive https://github.com/marlonrichert/zsh-autocomplete.git ~/github/zsh-autocomplete

mkdir -p ~/Downloads
# Install fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip -P ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/InconsolataGo.zip -P ~/Downloads

sudo mkdir -p /usr/share/fonts/nerdfonts
cd ~/Downloads
sudo unzip -o "*.zip" "*.ttf" "*.otf" -d /usr/share/fonts/nerdfonts/
sudo fc-cache -f -v

# Download QT themes
#wget https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1687532960/Bluish-Dark-Kvantum.tar.gz?response-content-disposition=attachment%3B%2520Bluish-Dark-Kvantum.tar.gz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20230713%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230713T095448Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=bdda392ec449548040287520d919f82aca056a512b1250077ebaf032f0dd21e0 -P ~/Downloads/

# Check if yay is installed
if yay --version &> /dev/null; then
    echo "yay is already installed"
else
    echo "yay is not installed"
    # Install yay
    git clone https://aur.archlinux.org/yay.git ~/github/yay
    cd ~/github/yay
    makepkg -si
    yay --version
fi

# Hyprland deps
yay -S xdg-desktop-portal-hyprland-git swaybg colord ffmpegthumbnailer gnome-keyring \
gtk-engine-murrine imagemagick kvantum pamixer playerctl polkit-kde-agent            \
qt5-quickcontrols qt5-quickcontrols2 qt5-wayland qt6-wayland sway-bg ttf-font-awesome tumbler \
ttf-jetbrains-mono ttf-icomoon-feather xdotool    \
xwaylandvideobridge-cursor-mode-2-git cliphist qt5-imageformats qt5ct

# Set kvantum theme
# kvantummanager --set Fluent-Dark 
kvantummanager --set Bluish-Dark-Kvantum

# CLI 
yay -S btop cava neofetch noise-suppression-for-voice    \
dunst rofi-lbonn-wayland-git rofi-emoji starship zsh viewnior ripgrep ncspot \
htop ark ncdu wofi gtop glances

# Wallpaper manager, swww is really efficient but can only do images and gifs, mpvpaper can play mp4s and do playlists etc.
#yay -S swww 
yay -S mpvpaper

# PipeWire 
yay -S pipewire pipewire-alsa pipewire-audio pipewire-pulse      \
pipewire-jack wireplumber gst-plugin-pipewire pavucontrol

# OBS
#yay -S obs-studio-rc ffmpeg-obs cef-minimal-obs-rc-bin 

# Hyprland
#yay -S hyprland-nvidia-git hyprpicker-git waybar-hyprland-git \
yay -S hyprland-git hyprpicker-git waybar-hyprland-git \
nwg-look wf-recorder wlsunset

# yay -S hyprland-git polkit-kde-agent dunst grimblast rofi-git rofi-emoji    \
# wl-clipboard wf-recorder wlogout grimblast-git hyprpicker-git hyprpaper-git \
# xdg-desktop-portal-hyprland-git ffmpegthumbnailer tumbler wtype colord      \
# imagemagick swaylock-effects qt5-wayland qt6-wayland ripgrep waybar-hyprland-git

# Dev + misc software
sudo pacman -S --noconfirm krita discord blender mpv vlc steam lutris wine \
man tldr lxappearance
yay -S obs-studio mangohud goverlay 

sudo updatedb # Update locate
yay -S ckb-next
sudo systemctl enable ckb-next-daemon
sudo ckb-next-daemon &

popd
