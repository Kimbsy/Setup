#!/bin/bash

##############################################################################################################
# Script for installing software and configuring settings to get from a fresh install to just how I like it. #
##############################################################################################################

# Add repositories.
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3

# Update apt.
sudo apt-get -y update && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean

# Install software.
sudo apt-get install -y vim tree htop lm-sensors sublime-text-installer vlc nemo openjdk-8-jdk terminator

# Clone repos
git clone git@github.com:Kimbsy/dotfiles.git ~/Projects/dotfiles

# Install functions and aliases from dotfiles repo.
cd ~/Projects/dotfiles/
./install.sh ~/.bashrc
cd
source ~/.bashrc

# Configure settings.
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
