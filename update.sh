#!/bin/sh

# Updates the dotfiles with the most current ones

# bashrc
cp $HOME/.bashrc bashrc
echo "Copied bashrc"

# xdg_config_home files
cp -r $HOME/.config/{hypr,kitty,micro,neofetch,swaylock,waybar} config/
echo "Copied .config directories"

# configuration.nix
cp /etc/nixos/configuration.nix .
echo "Copied config.nix"
