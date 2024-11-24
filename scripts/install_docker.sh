#!/bin/bash

#####################################################################################
# UPDATE #
echo "------ Installing Docker STARTED ------"
sudo apt-get -y update >/dev/null 2>&1

#####################################################################################
# INSTALLING FUNCTIONS #
# To reduce verbosity
function apt_install {
    for p in $@; do
        echo "installing $p"
        sudo apt-get -y install $p >/dev/null 2>&1
    done
}

#####################################################################################
# MODULES #

# Basics dependencies
apt_install ca-certificates curl gnupg lsb-release

# 1. Add Docker’s official GPG key:
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 2. Use the following command to set up the repository:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 3. Install Docker Engine
apt-get update
apt_install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 4. Enable docker
systemctl enable docker

# 5. Start docker
systemctl start docker 

# clean packages.
apt-get -y autoremove --purge
apt-get -y clean

echo "------ Installing Docker FINISHED! ------"
#####################################################################################