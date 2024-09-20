FROM debian:bullseye

RUN set -eux; \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        mariadb-server \
        mariadb-client && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.conf

# Make directories and give permissions
RUN mkdir -p /run/mysqld
RUN chown -R mysql:root /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql

# File to create users/databases in mariadb
RUN cat << EOF > /var/lib/mysql/init.sql \
CREATE DATABASE IF NOT EXISTS ${DB_NAME}; \
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}'; \
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}'; \
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASS}' WITH GRANT OPTION; \
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}' WITH GRANT OPTION; \
FLUSH PRIVILEGES; \
EOF

# Execute permissions to file
RUN chmod +x /var/lib/mysql/init.sql

EXPOSE 3306

CMD  ["mysqld", "--init-file=/var/lib/mysql/init.sql", "--bind-address=0.0.0.0"]
