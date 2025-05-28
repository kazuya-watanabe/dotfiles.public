#!/usr/bin/env bash

cat <<EOF | xargs brew install --cask
adguard-vpn
alfred
appcleaner
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
fd
fnm
fzf
gh
git-delta
git-flow-avh
jq
lazygit
lesspipe
lf
libsixel
lsd
p7zip
pandoc
poppler
ripgrep
starship
svg2png
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
