#!/bin/bash

#####################################################################################
# UPDATE #
echo "------ Bootstraping System STARTED ------"
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
apt_install wget git curl vim net-tools gnupg zsh 

# Config git
git config --global user.name "shikunwei"
git config --global user.email "shikunwei.21@gmail.com"
git config --global credential. helper store
git config --global pull.ff only

# Config Oh My Zsh
echo "*** Configuring Oh My Zsh ***"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z

THEME="powerlevel10k\/powerlevel10k"; sed -i s/^ZSH_THEME=".\+"$/ZSH_THEME=\"$THEME\"/g ~/.zshrc && echo "Edited theme line in ~/.zshrc :" && cat ~/.zshrc | grep -m 1 ZSH_THEME
sed -i s/^plugins=".\+"$/'plugins=\(git zsh-autosuggestions zsh-syntax-highlighting zsh-z extract\)'/g ~/.zshrc && echo "Edited plugin line in ~/.zshrc :" && cat ~/.zshrc | grep -m 1 "^plugins="

# clean packages.
apt-get -y autoremove --purge
apt-get -y clean


echo "------ Bootstraping System FINISHED! ------"
#####################################################################################