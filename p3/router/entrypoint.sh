#!/bin/sh

HOSTNAME=$(hostname)
echo "Starting node: $HOSTNAME"

# Assign the correct loopback IP based on the node's hostname
case "$HOSTNAME" in
    *_aaudeber-2) LOCAL_IP="1.1.1.2" ;;
    *_aaudeber-3) LOCAL_IP="1.1.1.3" ;;
    *_aaudeber-4) LOCAL_IP="1.1.1.4" ;;
    *)            LOCAL_IP="" ;;
esac

# If the node is a Leaf VTEP, configure the local bridge and VXLAN interface
if [ -n "$LOCAL_IP" ]; then
    echo "Configuring network interfaces for Leaf VTEP (IP: $LOCAL_IP)..."
    
    # Create the bridge interface br0
    ip link add br0 type bridge
    ip link set br0 up
    
    # eth0 is connected to the host -> add it to the bridge br0
    ip link set eth0 up
    ip link set eth0 master br0
    
    # Create the VXLAN 10 interface mapped to the local loopback IP
    ip link add vxlan10 type vxlan id 10 dstport 4789 local $LOCAL_IP
    ip link set vxlan10 up
    ip link set vxlan10 master br0
else
    echo "Route Reflector detected. No VXLAN or local bridge required."
fi

# Start the FRR suite (Zebra, bgpd, ospfd, etc.)
/usr/lib/frr/frrinit.sh start

# Keep the container running
exec tail -f /dev/null
