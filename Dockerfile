FROM mono:5.14

# Define ECO Version
ENV ECO_VERSION=8.3.3
ENV ECO_FILE_HOST=https://s3-us-west-2.amazonaws.com/eco-releases
ENV ECO_ZIP=EcoServer_v0.${ECO_VERSION}-beta.zip

WORKDIR /opt/eco

# APT update, install tmux install mono specific version + cleanup
RUN apt get update && \
    apt install -y tmux unzip curl vim && \
    curl -O https://s3-us-west-2.amazonaws.com/eco-releases/EcoServer_v0.${ECO_VERSION}-beta.zip && \
    curl -O ${ECO_FILE_HOST}/${ECO_ZIP} && \
    unzip ${ECO_ZIP} && \
    rm -f ${ECO_ZIP} && \
    apt -y autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

# Game port
EXPOSE 3000/udp
# Web port
EXPOSE 3001

# Ensure data are saved externally
VOLUME [ "/opt/eco" ]

# Using script to ensure no arguments car be sent to the container when starting.
ENTRYPOINT [ "entrypoint.sh" ]