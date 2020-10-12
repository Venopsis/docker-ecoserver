FROM mono:5.14

# Set exposed port for container
ENV GAME_PORT 3000/udp
ENV WEB_PORT 3001

# Set time zone
ENV TZ Europe/Brussels

WORKDIR /opt/eco

# APT update, install tmux install mono specific version + cleanup
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt update && \
    apt install -y tmux unzip curl vim && \
    curl -O https://s3-us-west-2.amazonaws.com/eco-releases/EcoServerLinux_v0.9.0.4-beta.zip && \
    unzip EcoServerLinux_v0.9.0.4-beta.zip && \
    rm -f EcoServerLinux_v0.9.0.4-beta.zip && \
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