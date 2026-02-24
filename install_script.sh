#!/bin/bash

sudo dnf install gnome-shell --setopt=install_weak_deps=False -y

# Minimal gnome apps

sudo dnf install flatpak --setopt=install_weak_deps=False -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak update --refresh

flatpak install flathub org.gnome.Showtime org.gnome.Loupe org.gnome.TextEditor net.nokyan.Resources com.mattjakeman.ExtensionManager org.gnome.baobab io.bassi.Amberol org.gnome.SimpleScan -y

sudo dnf install gnome-weather gnome-calendar gnome-clocks gnome-terminal gnome-calculator nautilus gnome-shell-extension-user-theme gnome-shell-extension-dash-to-dock --setopt=install_weak_deps=False -y

# Install power-profiles-daemon instead of tuned
sudo dnf install power-profiles-daemon --setopt=install_weak_deps=False -y

sudo dnf copr enable solopasha/hyprland -y
sudo dnf copr enable atim/starship -y

sudo dnf install kitty matugen starship ulauncher \
	python3-pip tar --setopt=install_weak_deps=False -y

export PATH="$HOME/.local/bin:$PATH"
pip3 install --upgrade gnome-extensions-cli

gext install activate_gnome@isjerryxiao \
	clipboard-indicator@tudmotu.com \
	color-picker@tuberry \
	dash-to-dock@micxgx.gmail.com \
	deathclock@prabuddh.in \
	ding@rastersoft.com \
	gsconnect@andyholmes.github.io \
	hide-system-icons@shichen35.github.io \
	ProxySwitcher@flannaghan.com \
	quick-settings-audio-panel@rayzeq.github.io \
	rounded-window-corners@fxgn \
	tilingshell@ferrarodomenico.com \
	user-theme@gnome-shell-extensions.gcampax.github.com

mkdir -p ~/.icons
curl -L https://raw.githubusercontent.com/fb24m/dotfiles/main/icons.tar.xz | tar -xJ -C ~/.icons

gsettings set org.gnome.desktop.interface icon-theme 'Google'
gsettings set org.gnome.desktop.interface cursor-theme 'Moga-Cursor'
gsettings set org.gnome.desktop.interface gtk-theme 'Material You'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

gsettings set org.gnome.desktop.interface cursor-size 32

# Install Apps

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf install code -y

sudo dnf install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -y

# Generate and set up theme

mkdir -p ~/.config/matugen
curl -L https://raw.githubusercontent.com/fb24m/dotfiles/main/matugen.tar.xz | tar -xJ -C ~/.config/matugen

mkdir -p ~/.local/share/fonts
curl -L https://raw.githubusercontent.com/fb24m/dotfiles/main/fonts.tar.xz | tar -xJ -C ~/.local/share/fonts

mkdir -p ~/.local/share/gnome-shell/extensions/panel-bottom@custom
curl -L https://raw.githubusercontent.com/fb24m/dotfiles/main/panel-bottom.tar.xz | tar -xJ -C ~/.local/share/gnome-shell/extensions/panel-bottom@custom

matugen color hex "#ffffff" # IMAGE HERE

dconf write /org/gnome/shell/extensions/user-theme/name "'Material You'"

gnome-extensions enable panel-bottom@custom

# dash to dock settings
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 25
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'

sudo systemctl enable --now gdm
