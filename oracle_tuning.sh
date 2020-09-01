
#!/bin/ksh
# curl -s https://raw.githubusercontent.com/pedroaugustoferreira/service-amazonas-/master/install-zabbix-ibm-power-aix7.2.sh | bash -s --

cat > /usr/bin/oracle_tuning.sh << EOF
#!/usr/bin/ksh
/usr/sbin/no -o udp_sendspace=65536
/usr/sbin/no -o udp_recvspace=655360
/usr/sbin/no -o tcp_sendspace=65536
/usr/sbin/no -o tcp_recvspace=65536
/usr/sbin/no -o rfc1323=1
/usr/sbin/no -o sb_max=4194304
/usr/sbin/no -o ipqmaxlen=512
stopsrc -s xntpd;startsrc -s xntpd
EOF

chmod +x /usr/bin/oracle_tuning.sh

mkitab "oracle_tuning:2:once:/usr/bin/oracle_tuning.sh >/dev/null 2>&1"

chown oracle:dba /dev/rdiskASM*
chmod 660 /dev/rdiskASM*
ls -l /dev/rdiskASM*


