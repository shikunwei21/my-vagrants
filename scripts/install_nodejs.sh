#!/bin/bash

#####################################################################################
# MODULES #

# install nodejs 18 LTS version the official way
# curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

# install nvm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# config nvm
cat << EOF >> ~/.zshrc
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

cat << EOF >> ~/.bashrc
export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

# install nodejs
source ~/.profile
nvm install 18

# yarn
corepack enable yarn

# 全局安装 pnpm
npm i -g pnpm

echo '------ SETUP NodeJS FINISHED! ------'
#####################################################################################