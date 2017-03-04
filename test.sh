echo "foo"


# #!/bin/bash

# ##############################################################################################################
# # Script for installing software and configuring settings to get from a fresh install to just how I like it. #
# ##############################################################################################################

# # Install git.
# sudo apt-get install git &&

# # Create required directories.
# mkdir -p ~/Tools ~/Projects &&

# # Generate ssh key.
# printf "\nEnter your email address: " &&
# read EMAIL &&
# ssh-keygen -t rsa -b 4096 -C "$EMAIL" &&
# eval "$(ssh-agent -s)" &&
# ssh-add ~/.ssh/id_rsa &&

# # Add ssh key to git.
# printf "\nCreate a new ssh key in github with the following public key:\n\n" &&
# cat ~/.ssh/id_rsa.pub &&
# printf "\nHit enter to proceed." &&
# read enter &&

# # Configure git
# git config --global user.email $EMAIL &&
# printf "\nEnter GitHub username: " &&
# read GHUSER &&
# git config --global user.name $GHUSER &&

# # Clone Setup repo and execute setup script.
# git clone git@github.com:Kimbsy/Setup.git ~/Projects/Setup &&

# # Add repositories.
# sudo add-apt-repository -y ppa:webupd8team/sublime-text-3 && # Sublime Text 3

# # Update apt.
# sudo apt-get -y update && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean &&

# # Install software.
# sudo apt-get install -y vim tree htop lm-sensors sublime-text-installer vlc nemo openjdk-8-jdk terminator gparted &&

# # Clone repos
# git clone git@github.com:Kimbsy/dotfiles.git ~/Projects/dotfiles &&

# # Install functions and aliases from dotfiles repo.
# cd ~/Projects/dotfiles/ &&
# ./install.sh ~/.bashrc &&
# cd &&
# source ~/.bashrc &&

# # Configure settings.
# gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
