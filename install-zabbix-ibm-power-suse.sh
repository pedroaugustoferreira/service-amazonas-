rpm -Uvh --nosignature https://rpmfind.net/linux/opensuse/ports/ppc/distribution/leap/15.2/repo/oss/ppc64le/libopenssl1_1-1.1.1d-lp152.6.10.ppc64le.rpm
rpm -ivh --nosignature http://download.opensuse.org/repositories/server:/monitoring/openSUSE_Factory_PowerPC_standard/ppc64le/zabbix-agent-4.0.23-32.1.ppc64le.rpm


echo "PidFile=/run/zabbix/zabbix_agentd.pid" > /etc/zabbix/zabbix_agentd.conf
echo "LogFile=/var/log/zabbix/zabbix_agentd.log" >> /etc/zabbix/zabbix_agentd.conf
echo "EnableRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf
echo "LogRemoteCommands=1" >> /etc/zabbix/zabbix_agentd.conf
echo "Server=10.1.8.101" >> /etc/zabbix/zabbix_agentd.conf
echo "ServerActive=10.1.8.101" >> /etc/zabbix/zabbix_agentd.conf
echo "Hostname=$(hostname -s)" >> /etc/zabbix/zabbix_agentd.conf

systemctl enable zabbix_agentd.service;systemctl start zabbix_agentd.service;sleep 3;tail /var/log/zabbix/zabbix_agentd.log;ifconfig;systemctl status zabbix_agentd.service

