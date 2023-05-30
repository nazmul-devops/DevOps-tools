#!/bin/bash

# Update the system
sudo apt-get update

# Install vsftpd
sudo apt-get install -y vsftpd

# Backup the original configuration file
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.original

# Configure vsftpd
sudo sh -c 'echo "anonymous_enable=NO" >> /etc/vsftpd.conf'
sudo sh -c 'echo "local_enable=YES" >> /etc/vsftpd.conf'
sudo sh -c 'echo "write_enable=YES" >> /etc/vsftpd.conf'
sudo sh -c 'echo "local_umask=022" >> /etc/vsftpd.conf'
sudo sh -c 'echo "chroot_local_user=YES" >> /etc/vsftpd.conf'
sudo sh -c 'echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf'

# Create an FTP user
sudo useradd -m ftpuser
sudo passwd ftpuser

# Restart vsftpd service
sudo systemctl restart vsftpd

