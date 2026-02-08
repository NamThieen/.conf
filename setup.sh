#!/bin/bash
sudo su
echo "Clone dotfiles"

git clone https://github.com/NamThieen/.conf
sudo dnf install stow emacs-pgtk
cd .conf
stow fish
dnf install fish
chsh -s /usr/bin/fish

echo "Install Flathub"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Install Browser and Software Manager"

flatpak install app.zen_browser.zen bazaar

echo "Install Classin"

git clone https://github.com/NamThieen/clam/releases/download/v6.0.0/clam.rpm

dnf install clam.rpm
rm clam.rpm

