#!/bin/sh

HOSTNAME=$(hostname)
echo "Starting node: $HOSTNAME"

case "$HOSTNAME" in
    *_aaudeber-2) LOCAL_IP="1.1.1.2" ;;
    *_aaudeber-3) LOCAL_IP="1.1.1.3" ;;
    *_aaudeber-4) LOCAL_IP="1.1.1.4" ;;
    *)            LOCAL_IP="" ;;
esac

if [ -n "$LOCAL_IP" ]; then
    echo "Configuring network interfaces for Leaf VTEP (IP: $LOCAL_IP)..."
    
    ip link add br0 type bridge
    ip link set br0 up
    
    ip link set eth0 up
    ip link set eth0 master br0
    
    ip link add vxlan10 type vxlan id 10 dstport 4789 local $LOCAL_IP
    ip link set vxlan10 up
    ip link set vxlan10 master br0
fi

TEMPLATE_FILE="/etc/frr/templates/${HOSTNAME}.conf"
TARGET_CONF="/etc/frr/frr.conf"

if [ -f "$TEMPLATE_FILE" ]; then
    echo "Applying distinct FRR configuration from: $TEMPLATE_FILE"
    cp "$TEMPLATE_FILE" "$TARGET_CONF"
else
    echo "Warning: No specific configuration template found for $HOSTNAME. Using default fallback."
fi

chown frr:frr $TARGET_CONF

/usr/lib/frr/frrinit.sh start

exec tail -f /dev/null
