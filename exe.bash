#!/bin/bash

# Install OpenVPN and dependencies
apt-get update
apt-get install -y openvpn resolvconf

# Create the OpenVPN client configuration file
cat > /etc/openvpn/client.conf << EOF
client
dev tun
proto udp
remote <SERVER_IP_ADDRESS> <SERVER_PORT>
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
ca ca.crt
cert client.crt
key client.key
EOF

# Download the necessary OpenVPN files
cd /etc/openvpn
wget <SERVER_URL>/ca.crt
wget <SERVER_URL>/client.crt
wget <SERVER_URL>/client.key

# Start the OpenVPN client
openvpn --config /etc/openvpn/client.conf
