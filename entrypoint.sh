#! /usr/bin/env bash
set -e

# if running as root, switch to hubot-slack user
if [[ $EUID -eq 0 ]]; then
  su - hubot-slack
fi

mkdir -p $HOME/thebot
cd $HOME/thebot

# if there are no files in the directory then we need to generate the app
if [[ $(ls -l | wc -l) -eq 0 ]]; then
  npm install -g yo generator-hubot
  yo hubot --owner="$HUBOT_OWNER" --name="$HUBOT_NAME" --description="$HUBOT_DESC" --adapter="$HUBOT_ADAPTER" --defaults
fi

# if redis-server is not running, run it in the background
if [[ -z "$(pgrep redis-server)" ]]; then
  nohup redis-server &
fi

exec "$@"
