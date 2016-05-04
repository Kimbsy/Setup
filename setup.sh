#!/bin/bash

##############################################################################################################
# Script for installing software and configuring settings to get from a fresh install to just how I like it. #
##############################################################################################################

# Ensure script is run with root priveleges
if [[ $EUID -ne 0 ]]; then
	printf "You must run this script as root\n" 1>&2
	exit 1
fi

# Add repositories.
add-apt-repository -y ppa:webupd8team/sublime-text-3

# Update apt.
sudo apt-get -y update && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean

# Install software.
apt-get install -y vim tree htop lm-sensors sublime-text-installer vlc nemo

# Clone repos.
git clone git@github.com:Kimbsy/dotfiles.git ~/Projects/dotfiles

# Configure settings.
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
