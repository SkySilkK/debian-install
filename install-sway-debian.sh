#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y nala

# Essential utilities
sudo nala install -y gammastep tmux htop btop zsh curl wget unzip git fzf fd-find ripgrep ffmpeg jq brightnessctl pipx python3-dev zoxide

#Install stow
sudo nala install -y stow

#Install compilers and build systems
sudo nala install -y gcc meson

#For firefox install TTS
sudo nala install -y speech-dispatcher

#Change default shell to zsh
sudo chsh -s $(which zsh)

# Swaywm install
sudo nala install -y sway waybar sway-notification-center libnotify-bin wofi wl-clipboard xdg-desktop-portal-wlr swaybg

#Install gui apps
sudo nala install -y thunar gamin thunar-archive-plugin tumbler ffmpegthumbnailer tumbler-plugins-extra

#Music/Video player & Volume control
sudo nala install -y mpv pavucontrol pamixer

#Install pdf viewer
sudo nala install -y zathura

# For legacy apps(x11) support on sway wayland
sudo nala install -y wayland-protocols xwayland xorg mesa-utils
sudo nala install -y xdg-user-dirs
sudo nala install -y lxqt-policykit

# Install flatpak for containerized gui apps
sudo nala install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install firefox via flatpak
flatpak install --assumeyes org.mozilla.firefox
flatpak install --assumeyes org.onlyoffice.desktopeditors
flatpak install --assumeyes com.github.johnfactotum.Foliate
flatpak install --assumeyes org.mozilla.Thunderbird
flatpak install --assumeyes net.lutris.Lutris
flatpak install --assumeyes org.qbittorrent.qBittorrent
flatpak install --assumeyes com.github.tchx84.Flatseal
#Create a new directory and copy bitmap fonts to directory for flatpak firefox github fonts fix
mkdir -p ~/.var/app/org.mozilla.firefox/config/fontconfig/conf.d/
cp /etc/fonts/conf.d/70-no-bitmaps.conf ~/.var/app/org.mozilla.firefox/config/fontconfig/conf.d/

#Fonts and icons
sudo nala install -y fonts-noto-color-emoji fonts-font-awesome
sudo nala install -y fonts-deva-extra fonts-indic fonts-noto-cjk fonts-recommended

#Installing nerd fonts
echo ==============================================
echo "Installing nerd fonts"
echo ==============================================
echo "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
curl -OL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
echo "creating fonts folder: ${HOME}/.fonts"
mkdir -p "$HOME/.fonts"
echo "unzip the FiraCode.zip"
unzip -o "FiraCode.zip" -d "$HOME/.fonts/FiraCode/"
fc-cache -f
echo "done!"
echo "Cleaning firacode from home directory"
rm FiraCode.zip

#Install wezterm
if [ "$(which wezterm | wc -l)" -ge 1 ]; then
	echo ==============================================
	echo Wezterm is already installed
	echo ==============================================
else
	echo ==============================================
	echo Installing Wezterm
	echo ==============================================

	curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
	echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
	sudo nala update
	sudo nala install -y wezterm
fi

# Install rustup (Silent Install)
if [ "$(which cargo | wc -l)" -ge 1 ]; then
	echo ==============================================
	echo Cargo is already installed
	echo ==============================================
else
	echo ==============================================
	echo Installing cargo via Rustup
	echo ==============================================
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	export PATH=$PATH:$HOME/.cargo/bin/
fi

#Install bob for neovim
cargo install bob-nvim
bob install nightly
bob use nightly

#Install lazyvim

#Backup current neovim
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

#Actual installtion
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# For some reason this command doesn't work export PATH=$PATH:$HOME/.local/share/bob/nvim-bin
# Install eza for icons
cargo install eza

#Install terminal file manager
cargo install yazi

#Install wallpaper utility waypaper
sudo nala install -y pkg-config libcairo2-dev libgirepository1.0-dev

#Enable hyprland like autotiling
pipx install autotiling

#add all stow configs
stow .
#Reboot the system
echo ==============================================
echo "Please reboot your system"
echo ==============================================

echo **********************************************
read -p "Do you want to restart the pc (yes/no)" yn

case $yn in
yes)
	echo Restarting your pc....
	sleep 2
	systemctl reboot
	;;
no)
	echo please reboot your pc later, flatpak apps will not be visible in wofi until reboot
	exit
	;;
*)
	echo Invalid response
	;;
esac
