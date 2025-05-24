sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

sudo dnf update -y

sudo dnf install -y cascadia-mono-nf-fonts
sudo dnf install -y gimp
sudo dnf install -y gimp-help-ja
sudo dnf install -y inkscape
sudo dnf install -y inkscape-docs
sudo dnf install -y java-21-openjdk
sudo dnf install -y java-21-openjdk-devel
sudo dnf install -y kitty
sudo dnf install -y libreoffice
sudo dnf install -y libreoffice-help-ja
sudo dnf install -y libreoffice-langpack-ja
sudo dnf install -y python3-pip
sudo dnf install -y thunderbird
sudo dnf install -y vlc-gui-qt
sudo dnf install -y zsh

sudo dnf install -y akmod-nvidia
sudo dnf install -y xorg-x11-drv-nvidia-cuda
sudo dnf install -y xorg-x11-drv-nvidia-cuda-libs
sudo dnf install -y xorg-x11-drv-nvidia-power

sudo systemctl enable nvidia-{suspend,resume,hibernate}
