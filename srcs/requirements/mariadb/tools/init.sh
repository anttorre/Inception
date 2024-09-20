#!/bin/sh

# Make directories and give permissions
mkdir -p /run/mysqld
chown -R mysql:root /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# File to create users/databases in mariadb
cat << EOF > /var/lib/mysql/init.sql
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASS}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Execute permissions to file
chmod +x /var/lib/mysql/init.sql

# Start mariadb with the correct file to execute
exec mysqld --init-file=/var/lib/mysql/init.sql --bind-address=0.0.0.0
