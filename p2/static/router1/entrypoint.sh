#!/bin/sh

echo "Waiting for GNS3 to plug eth1..."
while ! ip link show dev eth1 >/dev/null 2>&1; do
    sleep 0.5
done
sleep 1

ip addr add 10.0.0.1/24 dev eth1
ip link set dev eth1 up

ip link add br0 type bridge
ip link set dev br0 up

ip link set dev eth0 up
ip link set dev eth0 master br0

ip link add vxlan10 type vxlan id 10 remote 10.0.0.2 dstport 4789 dev eth1
ip link set dev vxlan10 up

ip link set dev vxlan10 master br0

echo "Network configuration deployed successfully!"
/usr/lib/frr/frrinit.sh start
exec tail -f /dev/null
