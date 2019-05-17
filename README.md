hubot-slack-docker
---
A docker container to simplify running Hubot in slack.

### Usage
When running the docker container, five environment variables _must_ be passed.

| Variable | Purpose | Example |
| :------- | :------ | :------ |
| HUBOT_OWNER | Who owns this bot? | "John Ruiz <jruiz@johnruiz.com>" |
| HUBOT_NAME | The name of the bot | "Hubot" |
| HUBOT_DESC | Your clever description of your bot | "GitHub's hardest worker" |
| HUBOT_ADAPTER | Which chat adapter to use | "slack" |
| HUBOT_SLACK_TOKEN | The slack token for the bot to use | "xoxp-YOUR-TOKEN-HERE" |

Additionally, the power of Hubot comes from extension scripts so you'll 
probably want to mount a local scripts directory into the docker container.

Here's an example `docker run` command:

```
mkdir $HOME/hubot-scripts
docker run --name hubot \
  --restart always \
  --env HUBOT_OWNER="John Ruiz <jruiz@johnruiz.com" \
  --env HUBOT_NAME="Hubot" \
  --env HUBOT_DESC="GitHub's hardest worker" \
  --env HUBOT_ADAPTER="slack" \
  --env HUBOT_SLACK_TOKEN="xoxp-YOUR-TOKEN-HERE" \
  -v $HOME/hubot-scripts:/home/hubot-slack/thebot/scripts \
  docker.pkg.github.com/jar349/hubot-slack-docker/hubot-slack-docker:latest
```

In order to retain state between restarts, the container should be stopped and
started via `docker stop hubot` and `docker start hubot`.  Of course, you
should use whatever you passed to `--name` in the `docker run` command above.

This should give you a running hubot connected to your slack but before you
can interact with it, you'll need to invite it to your channel.  Its username
is the value you passed to the `HUBOT_NAME` environment variable.  So assuming
you used `Hubot`:

```
/invite @Hubot
```

Once invited, you should be able to ping Hubot:

```
@Hubot ping
```

