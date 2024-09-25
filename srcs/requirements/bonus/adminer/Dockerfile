FROM debian:bullseye

RUN set -eux; \
 	apt-get update; \
 	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	wget \
	php-cli \
	php-mysqli \
	php-json \
	php-curl \
	php-zip \
	php-xml \
	php-mbstring \
	ca-certificates \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*i

RUN mkdir -p /var/www/html \
   	&& wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" \
	-O /var/www/html/index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
