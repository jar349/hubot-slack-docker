FROM debian:buster-slim
LABEL Maintainer "John Ruiz <jruiz@johnruiz.com>"

# prerequisites requiring root
RUN apt update && apt install -y redis-server procps curl
RUN adduser --quiet --disabled-password --gecos hubot-slack hubot-slack
COPY ./ /home/hubot-slack/
RUN mkdir -p /home/hubot-slack/thebot && \
    chown -R hubot-slack:hubot-slack /home/hubot-slack && \
    chmod +x /home/hubot-slack/*.sh

ENTRYPOINT [ "/home/hubot-slack/entrypoint.sh" ]
CMD [ "/home/hubot-slack/run-hubot.sh" ]

