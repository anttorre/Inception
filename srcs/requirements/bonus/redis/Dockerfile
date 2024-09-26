FROM debian:bullseye

WORKDIR /usr/src/app

RUN set -eux; \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	redis-server \
	wget \
	curl \
	ca-certificates

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /data

EXPOSE 6379

COPY conf/redis.conf /usr/local/etc/redis/redis.conf

CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
