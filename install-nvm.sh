#! /usr/bin/env bash
set -e

if [[ ! -z "$DEBUG" ]]; then
  set -x
fi

# if there's an npm command available, no need to re-install nvm
npm -v 2>/dev/null && exit 0

export NVM_DIR=$HOME/.nvm
export NODE_VERSION=10.15.3

mkdir -p $NVM_DIR

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

echo "export NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules" >> $HOME/.bashrc
echo "export PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH" >> $HOME/.bashrc

node -v
npm -v

