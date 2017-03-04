#!/bin/bash

##############################################################################################################
# Script for installing software and configuring settings to get from a fresh install to just how I like it. #
##############################################################################################################

# Install git.
sudo apt-get install git &&

# Create required directories.
mkdir -p ~/Tools ~/Projects &&

# Check if ssh key exists.
ssh_key="~/.ssh/id_rsa.pub"
if [ ! -f "$ssh_key" ]; then
    # Generate ssh key.
    printf "\nEnter your email address: " &&
    read email &&
    ssh-keygen -t rsa -b 4096 -C "$email" &&
    eval "$(ssh-agent -s)" &&
    ssh-add ~/.ssh/id_rsa &&

    # Add ssh key to git.
    printf "\nCreate a new ssh key in GitHub with the following public key:\n\n" &&
    cat "$ssh_key"
else
    printf "\nSSH key $ssh_key already exists. Ensure key is registered in GitHub.\n\n"
fi

printf "\nHit enter to proceed." &&
read enter &&

# Configure git

    # @TODO: check if git is configured already?

git config --global user.email $email &&
printf "\nEnter GitHub username: " &&
read gh_username &&
git config --global user.name $gh_username &&

# Check if Setup repo exists.
setup_repo="~/Projects/Setup"
if [ ! -d "$setup_repo" ]; then
    # Clone Setup repo.
    git clone git@github.com:Kimbsy/Setup.git "$setup_repo"
fi

# Add repositories.
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3 &&

# Update apt.
sudo apt-get -y update && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean &&

# Install software.
sudo apt-get install -y vim tree htop lm-sensors sublime-text-installer vlc nemo openjdk-8-jdk terminator gparted &&

# Clone repos
git clone git@github.com:Kimbsy/dotfiles.git ~/Projects/dotfiles &&

# Install functions and aliases from dotfiles repo.
cd ~/Projects/dotfiles/ &&
./install.sh ~/.bashrc &&
cd - &&
source ~/.bashrc &&

# Configure settings.
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
