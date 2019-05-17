FROM node:8-stretch-slim
LABEL Maintainer "John Ruiz <jruiz@johnruiz.com>"

# prerequisites requiring root
RUN apt update && apt install -y redis-server
RUN adduser --quiet --disabled-password --gecos hubot-slack hubot-slack
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "/home/hubot-slack/thebot/bin/hubot", "--adapter", "slack" ]

