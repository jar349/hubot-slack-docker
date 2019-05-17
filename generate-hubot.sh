#! /usr/bin/env bash
set -e

BOT_DIR="$HOME/thebot"
NVM_DIR="$HOME/.nvm"
DEBUG=$5

if [[ ! -z "$DEBUG" ]]; then
  set -x
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

mkdir -p $HOME/.config/insight-nodejs
cd $BOT_DIR

# if there are no files in the directory then we need to generate the app
# if the user mounted a script directory in $BOT_DIR then we should expect up
# to one file already in $BOT_DIR
if [[ $(ls -1 | wc -l) -gt 1 ]]; then
  echo "hubot is already generated in $PWD"
else
  echo "hubot is not already generated in $PWD... generating..."
  # yeoman uses insight to ask for permission to send info back
  tee $HOME/.config/insight-nodejs/insight-yo.json <<EOF
{
  "clientId": 265145436419,
  "optOut": true
}
EOF

  # have to re-target $HOME due to --preserve-environment
  npm install yo generator-hubot
  ./node_modules/.bin/yo hubot --owner="$1" --name="$2" --description="$3" --adapter="$4" --defaults
fi

