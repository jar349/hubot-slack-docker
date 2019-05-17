#! /usr/bin/env bash
set -e

if [[ ! -z "$DEBUG" ]]; then
  set -x
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

BOT_DIR=$HOME/thebot
cd $BOT_DIR

# run the hubot cmd
HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN $BOT_DIR/bin/hubot --adapter slack
