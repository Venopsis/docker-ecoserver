FROM mono:5.14

# Set exposed port for container
ENV GAME_PORT 3000/udp
ENV WEB_PORT 3001

# Set time zone
ENV TZ Europe/Brussels

WORKDIR /opt/eco

# APT update + install tmux, unzip, curl, vim, nodejs + install eco specific version + cleanup
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - && \
    apt update && \
    apt install -y tmux unzip curl vim nodejs && \
    curl -O https://s3-us-west-2.amazonaws.com/eco-releases/EcoServer_v0.8.3.3-beta.zip && \
    unzip EcoServer_v0.8.3.3-beta.zip && \
    rm -f EcoServer_v0.8.3.3-beta.zip && \
    npm i cloudcmd -g --force && \
    npm cache clean --force && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# BP : Copy files after RUN commands
COPY entrypoint.sh /

# Game port
EXPOSE ${GAME_PORT}
# Web port
EXPOSE ${WEB_PORT}

# Ensure data are saved externally
VOLUME [ "/opt/eco" ]

# Using script to ensure no arguments car be sent to the container when starting.
ENTRYPOINT [ "/entrypoint.sh" ]
# Default is Init option
CMD [ "Init" ]