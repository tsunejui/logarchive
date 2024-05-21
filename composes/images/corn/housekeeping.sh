#! /bin/sh

store_log_path=/var/log/archive-haproxy.log

yesterday=$(date -d "@$(($(date +%s) - 86400))" +%Y-%m-%d)

echo "$(date -Iseconds) [$yesterday] To compress log files." >> $store_log_path

tar -czvf /var/log/haproxy.log.$yesterday.tar.gz /var/log/haproxy.log.$yesterday*

find /var/log -type f -regex "\/var\/log\/haproxy\.log\.$yesterday.*" -not -path "\/var\/log\/haproxy.log.$yesterday.tar.gz" -exec rm {} \;

find /var/log -type f -mtime +30 -regex "\/var\/log\/haproxy\.log.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].tar.gz" -exec rm {} \;

find /var/log -type f -mtime +30 -regex "\/var\/log\/fluentd\.log.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]" -exec rm {} \;

echo "$(date -Iseconds) [$yesterday] Compression completed." >> $store_log_path