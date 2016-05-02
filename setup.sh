#!/bin/bash

##############################################################################################################
# Script for installing software and configuring settings to get from a fresh install to just how I like it. #
##############################################################################################################

# Add repositories.
add-apt-repository -y ppa:webupd8team/sublime-text-3

# Update apt.
sudo apt-get update && sudo apt-get -y dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean

# Install software.
apt-get install -y vim tree htop lm-sensors sublime-text-installer

# Clone repos.
git clone git@github.com:Kimbsy/dotfiles.git ~/Projects/dotfiles

# Configure settings.
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true

