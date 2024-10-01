# Use Debian Bullseye as base image
FROM debian:bullseye

WORKDIR /usr/src/app

# Install dependencies
RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Portainer
RUN curl -L https://github.com/portainer/portainer/releases/download/2.21.0/portainer-2.21.0-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar -xzf portainer.tar.gz --strip-components=1 -C /usr/local/bin \
    && rm portainer.tar.gz

# Expose Portainer port
EXPOSE 9000

# Run the initialization script and then Portainer
CMD ["portainer", "--no-ssl"]

