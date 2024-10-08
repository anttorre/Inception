FROM debian:bullseye

WORKDIR /usr/src/app

RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/portainer/portainer/releases/download/2.21.0/portainer-2.21.0-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar -xzf portainer.tar.gz --strip-components=1 -C /usr/local/bin \
    && rm portainer.tar.gz

EXPOSE 9000

CMD ["portainer", "--no-ssl"]

