#!/usr/bin/env bash

cat <<EOF | xargs brew install --cask
acronis-true-image
firefox
font-hack-nerd-font
iterm2
microsoft-office
thunderbird@esr
EOF

cat <<EOF | xargs brew install --formula
bat
coreutils
docker
docker-compose
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
ripgrep
starship
unzip
vim
w3m
wget2
xz
zoxide
EOF

brew tap daipeihust/tap
brew install --formula im-select
