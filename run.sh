#!/usr/bin/env sh

export SYSTEM_NAMESERVER=$(awk '/nameserver/ {print $2; exit}' /etc/resolv.conf)

python3 /config.py > /usr/local/etc/haproxy/haproxy.cfg || exit $?

echo "--- Config preview: ---"
cat /usr/local/etc/haproxy/haproxy.cfg
echo "--- / Config preview ---"

haproxy -V -f /usr/local/etc/haproxy/haproxy.cfg
