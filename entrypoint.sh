#! /usr/bin/env bash
set -e

if [[ ! -z "$DEBUG" ]]; then
  set -x
fi

# if redis-server is not running, run it in the background
if [[ -z "$(pgrep redis-server)" ]]; then
  nohup redis-server &
fi

# install nvm and node as the hubot-slack user
su - hubot-slack --command "/home/hubot-slack/install-nvm.sh"

# generate a hubot project
su - hubot-slack --command "/home/hubot-slack/generate-hubot.sh \"$HUBOT_OWNER\" \"$HUBOT_NAME\" \"$HUBOT_DESC\" \"$HUBOT_ADAPTER\" \"$DEBUG\""

# run hubot
su - hubot-slack --command "HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN $@"
