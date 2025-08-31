#!/usr/bin/env bash

cat <<EOF | xargs brew install --cask
firefox
font-hack-nerd-font
iterm2
microsoft-office
thunderbird
EOF

cat <<EOF | xargs brew install --formula
bat
btop
coreutils
docker
efm-langserver
fd
ffmpeg
fnm
fzf
gh
git-flow-avh
imagemagick
jq
lazygit
lesspipe
lf
lima
lsd
p7zip
pandoc
poppler
portaudio
ripgrep
starship
universal-ctags
unzip
vim
w3m
watchman
wget2
xz
zoxide
EOF

brew tap daipeihust/tap
brew install --formula im-select
