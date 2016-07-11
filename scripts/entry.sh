#!/bin/bash
set -v set -v set -v set -v set -v 

hostname $HOSTNAME
IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
echo $IP $DOMAIN $HOSTNAME >> /etc/hosts
echo domain $DOMAIN >> /etc/resolv.conf
chown clamav:clamav /var/log/mail/clamav.log
postfix -c /etc/postfix set-permissions
chown root:postdrop /usr/sbin/postqueue /usr/sbin/postdrop
chmod g+s /usr/sbin/postqueue /usr/sbin/postdrop
find /var/run -name "*.pid" | xargs rm
mkdir -p /usr/share/perl/5.18/Text
ln -s /usr/share/perl/5.18.2/Text/ParseWords.pm /usr/share/perl/5.18/Text/ParseWords.pm
 
/usr/local/bin/start-mailserver.sh 
