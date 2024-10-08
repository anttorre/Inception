FROM debian:bullseye

RUN set -eux; \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        vsftpd && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty

COPY tools/setup-ftp.sh /
RUN chmod +x /setup-ftp.sh

RUN mkdir -p /var/ftp && \
   	chown -R ftp:ftp /var/ftp && \
	chmod -R 775 /var/ftp

EXPOSE 21

CMD ["/setup-ftp.sh"]
