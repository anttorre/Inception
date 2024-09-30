#!/bin/sh

# Print starting message
echo "Starting FTP setup..."

# Add FTP user with no password and no user information
echo "Creating user $FTP_USER"
adduser --disabled-password --gecos "" $FTP_USER

# Set the FTP user password
echo "Setting password for $FTP_USER"
echo "$FTP_USER:$FTP_PASS" | chpasswd

# Configure vsftpd
echo "Configuring vsftpd"
cat <<EOL > /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist
secure_chroot_dir=/var/run/vsftpd/empty
local_root=/var/ftp/files
EOL

# Add the user to the vsftpd userlist
echo "Adding user $FTP_USER to userlist"
echo "$FTP_USER" >> /etc/vsftpd.userlist

# Create the /var/files_ftp directory and set permissions
echo "Creating /var/files_ftp directory"
mkdir /var/ftp/files
chown -R ftp:ftp /var/ftp/files
chmod -R 775 /var/ftp/files
usermod -aG ftp anttorre

# Start vsftpd in the foreground
echo "Starting vsftpd"
exec /usr/sbin/vsftpd /etc/vsftpd.conf
