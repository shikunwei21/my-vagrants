#!/bin/bash

#####################################################################################
# UPDATE #
echo "------ SETUP python dependencies ------"
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

function pip_install {
    for p in $@; do
        echo "installing $p"
        sudo pip install $p >/dev/null 2>&1
    done
}

#####################################################################################
# MODULES #
# Basics dependencies
apt_install python3-pip git

# pyenv
# ------------------------------------------------------------------------------
apt_install make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev

curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

cat << EOF >> ~/.zshrc
# pip config
export PATH="\$HOME/.local/bin:\$PATH"

# pyenv config
export PATH="\${HOME}/.pyenv/bin:\${PATH}"
export PYENV_ROOT="\${HOME}/.pyenv"
eval "\$(pyenv init -)"
EOF

cat << EOF >> ~/.bashrc
# pip config
export PATH="\$HOME/.local/bin:\$PATH"

# pyenv config
export PATH="\${HOME}/.pyenv/bin:\${PATH}"
export PYENV_ROOT="\${HOME}/.pyenv"
eval "\$(pyenv init -)"
EOF

# pipenv
# ------------------------------------------------------------------------------
pip_install pipenv 

# jupyter notebook
# ------------------------------------------------------------------------------
pip_install ipython jupyter

# Testing
# ------------------------------------------------------------------------------
# pip_install pytest  # https://github.com/pytest-dev/pytest

# fastapi
# ------------------------------------------------------------------------------
# pip_install fastapi uvicorn

# Code quality
# ------------------------------------------------------------------------------
# pip_install flake8
# pip_install isort
# pip_install pylint # Linter.
# pip_install black # Auto formatter.

# clean packages.
apt-get -y autoremove --purge
apt-get -y clean

echo '------ SETUP python FINISHED! ------'
#####################################################################################