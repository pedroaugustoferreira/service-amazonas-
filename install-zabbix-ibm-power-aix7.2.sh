#!/bin/ksh

mkdir /tmp/zabbix_install
cd /tmp/zabbix_install

wget https://www.zabbix.com/downloads/4.0.7/zabbix_agent-4.0.7-aix-7.2-powerpc-openssl.tar.gz

gzip -d zabbix_agent-4.2.1-aix-7.2-powerpc-openssl.tar.gz

tar -xf zabbix_agent-4.2.1-aix-7.2-powerpc-openssl.tar

#create zabbix group
mkgroup zabbix

#create zabbix user and at it to zabbix group
mkuser pgrp='zabbix' groups='zabbix' zabbix

#make configuration directory
mkdir /etc/zabbix

#make log directory
mkdir /var/log/zabbix/

#log directory belongs to user zabbix and group zabbix
chown -R zabbix:zabbix /var/log/zabbix/

#make configuration directory
mkdir -p /usr/local/etc/

#create direoctory for zabbix process file
mkdir -p /var/run/zabbix/

#process files directory belong to zabbix
chown -R zabbix:zabbix /var/run/zabbix/

#install zabbix_get and zabbix_sender binary 
cp bin/zabbix_* /bin/

#install zabbix_agent and zabbix_agentd binary
cp sbin/zabbix_agent* /sbin/

#copy configuration files
cp -r conf/zabbix_agent* /etc/zabbix/

#link configiguration file
ln -s /etc/zabbix/zabbix_agentd.conf /usr/local/etc/zabbix_agentd.conf

#backup original configuration file
mv /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf_bck

#create your own configuration file
echo "PidFile=/var/run/zabbix/zabbix_agentd.pid" > /etc/zabbix/zabbix_agentd.conf
echo "LogFile=/var/log/zabbix/zabbix_agentd.log" >> /etc/zabbix/zabbix_agentd.conf
echo "EnableRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf
echo "LogRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf
echo "Server=10.1.8.101" >> /etc/zabbix/zabbix_agentd.conf
echo "ServerActive=10.1.8.101" >> /etc/zabbix/zabbix_agentd.conf
echo "Hostname=$(hostname -s)" >> /etc/zabbix/zabbix_agentd.conf

#start zabbix agent
zabbix_agentd

mkitab "zabbix:2:once:/sbin/zabbix_agentd >/dev/null 2>&1"
