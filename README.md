# Setup
Repo for setting up a new Linux installation.

To begin:
```bash
# Create required directories.
mkdir Tools Projects &&

# Generate ssh key.
prinf "\nEnter your email address: " &&
read EMAIL &&
ssh-keygen -t rsa -b 4096 -C "$EMAIL" &&
eval "$(ssh-agent -s)" &&
ssh-add ~/.ssh/id_rsa &&

# Add ssh key to git.
printf "\nCreate a new ssh key in github with the following public key:\n\n" &&
cat ~/.ssh/id_rsa.pub &&
printf "\nHit enter to proceed." &&
read enter &&

# Confgigure git
git config --global user.email $EMAIL &&
prinf "\nEnter GitHub username: " &&
read GHUSER &&
git config --global user.name $GHUSER &&

# Clone Setup repo and execute setup script.
sudo apt-get install git &&
git clone git@github.com:Kimbsy/Setup.git Tools/Setup &&
sudo Tools/Setup/./setup.sh
```
