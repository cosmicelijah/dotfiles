#!/bin/sh



# if [ $EUID -ne 0 ]
	# then echo "Please run as root"
	# exit 1
# fi

cp bashrc $HOME/.bashrc
echo "Copied bashrc"

cp -r config/ $HOME/.config/
echo "Copied .config directories"

sudo cp configuration.nix /etc/nixos/configuration.nix
echo "Copied config.nix"
