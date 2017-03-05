#!/bin/bash

##############################################################################################################
# Script for installing software and configuring settings to get from a fresh install to just how I like it. #
##############################################################################################################

# Get user info.
printf "\nEnter your ubuntu username [kimbsy]: "
read u_username
u_username=${u_username:-kimbsy}

printf "\nEnter your email address: "
read email
email=${email:-}

# Install git.
sudo apt-get install -y git

# Create required directories.
mkdir -p "/home/$u_username/Tools" "/home/$u_username/Projects"

# Remove unwanted directories.
rm -rf "/home/$u_username/Templates" "/home/$u_username/Examples" "/home/$u_username/Public" "/home/$u_username/Music"

# Check if ssh key exists.
ssh_key="/home/$u_username/.ssh/id_rsa.pub"
if [ ! -f "$ssh_key" ]; then
    # Generate ssh key.
    ssh-keygen -t rsa -b 4096 -C "$email"
    eval "$(ssh-agent -s)"
    ssh-add "/home/$u_username/.ssh/id_rsa"

    # Add ssh key to git.
    printf "\nCreate a new ssh key in GitHub with the following public key:\n\n"
    cat "$ssh_key"
else
    printf "\nSSH key $ssh_key already exists. Ensure key is registered in GitHub.\n\n"
    cat "$ssh_key"
fi

printf "\nHit enter to proceed."
read enter

# Configure git.
git config --global user.email $email
printf "\nEnter GitHub username [Kimbsy]: "
read gh_username
gh_username=${gh_username:-Kimbsy}
git config --global user.name $gh_username

# Add repositories.
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3

# Update apt.
sudo apt-get -y update && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean

# Install software.
sudo apt-get install -y vim tree htop lm-sensors sublime-text-installer vlc nemo openjdk-8-jdk terminator gparted meld unity-tweak-tool

# Install Google Chrome.
if [ ! -n "$(type -t google-chrome-stable)" ] && [ ! "$(type -t google-chrome-stable)" = function ]; then
    cd "/home/$u_username/Tools"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt install -yf
    cd -
fi

# Remove unwanted software.
sudo apt remove -y firefox aisleriot gnome-sudoku libreoffice-impress libreoffice-draw gnome-mahjongg gnome-mines onboard gnome-orca thunderbird

# Clone repos.
setup_repo="/home/$u_username/Projects/Setup"
if [ ! -d "$setup_repo" ]; then
    git clone git@github.com:Kimbsy/Setup.git "$setup_repo"
fi
dotfiles_repo="/home/$u_username/Projects/dotfiles"
if [ ! -d "$dotfiles_repo" ]; then
    git clone git@github.com:Kimbsy/dotfiles.git "$dotfiles_repo"
fi

# Configure ubuntu settings.
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Make nemo default file browser.
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

# Install functions and aliases from dotfiles repo.
search_term="# Functions from Kimbsy/dotfiles repo."
file_name="/home/$u_username/.bashrc"
if ! grep -q "$search_term" "$file_name"; then
    cd "$dotfiles_repo"
    ./install.sh "/home/$u_username/.bashrc"
    cd -
fi
