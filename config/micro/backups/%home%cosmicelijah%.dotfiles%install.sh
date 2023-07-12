#!/bin/sh

if [ $EUID -ne 0 ]
	then echo "Please run as root"
	exit 1
fi

cp .bashrc $HOME/.bashrc

cp -r 