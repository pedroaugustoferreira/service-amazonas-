
#!/bin/ksh
# curl -s https://raw.githubusercontent.com/pedroaugustoferreira/service-amazonas-/master/oracle_tuning.sh | bash -s --

cat > /usr/bin/oracle_tuning.sh << EOF
#!/usr/bin/ksh
chdev -l en0 -a tcp_sendspace=65536
chdev -l en0 -a tcp_recvspace=65536
chdev -l en0 -a rfc1323=1
chdev -l en1 -a tcp_sendspace=65536
chdev -l en1 -a tcp_recvspace=65536
chdev -l en1 -a rfc1323=1
stopsrc -s xntpd;startsrc -s xntpd
EOF

chmod +x /usr/bin/oracle_tuning.sh

mkitab "oracle_tuning:2:once:/usr/bin/oracle_tuning.sh >/dev/null 2>&1"

chown oracle:dba /dev/rdiskASM*
chmod 660 /dev/rdiskASM*
ls -l /dev/rdiskASM*


exit 1
vi /etc/security/limits
root:
        nofiles = -1  
        nofiles_hard = -1   
        nproc = -1
        nproc_hard = -1
        stack = -1   
        stack_hard = -1   
        fsize = -1
        cpu = -1
        data = -1
        rss = -1
        fsize_hard = -1   
        core = -1
        threads = -1
        cpu_hard = -1
        data_hard = -1
        core_hard = -1
        rss_hard = -1
        threads_hard = -1
        
oracle:
        nofiles = -1  
        nofiles_hard = -1   
        nproc = -1
        nproc_hard = -1
        stack = -1   
        stack_hard = -1   
        fsize = -1
        cpu = -1
        data = -1
        rss = -1
        fsize_hard = -1   
        core = -1
        threads = -1
        cpu_hard = -1
        data_hard = -1
        core_hard = -1
        rss_hard = -1
        threads_hard = -1
