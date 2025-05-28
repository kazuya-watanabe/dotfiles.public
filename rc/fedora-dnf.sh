sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf update -y

cat <<EOF | xargs sudo dnf install -y
cascadia-mono-nf-fonts
gimp
gimp-help-ja
inkscape
inkscape-docs
java-21-openjdk
java-21-openjdk-devel
kitty
libreoffice
libreoffice-help-ja
libreoffice-langpack-ja
python3-pip
thunderbird
vlc-gui-qt
zsh

akmod-nvidia
xorg-x11-drv-nvidia-cuda
xorg-x11-drv-nvidia-cuda-libs
xorg-x11-drv-nvidia-power
EOF

sudo systemctl enable nvidia-{suspend,resume,hibernate}
