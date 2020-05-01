FROM mono:5.14

# Define ECO Version
#ENV ECO_VERSION=8.3.3
#ENV ECO_FILE_HOST=https://s3-us-west-2.amazonaws.com/eco-releases
#ENV ECO_ZIP=EcoServer_v0.${ECO_VERSION}-beta.zip
# Port via environment variable
ENV GAME_PORT 3000/udp
ENV WEB_PORT 3001

WORKDIR /opt/eco

COPY entrypoint.sh /

# APT update, install tmux install mono specific version + cleanup
RUN apt update && \
    apt install -y tmux unzip curl vim && \
    curl -O https://s3-us-west-2.amazonaws.com/eco-releases/EcoServer_v0.8.3.3-beta.zip && \
    unzip EcoServer_v0.8.3.3-beta.zip && \
    rm -f EcoServer_v0.8.3.3-beta.zip && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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