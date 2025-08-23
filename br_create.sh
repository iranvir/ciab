#!/bin/sh
sysctl -w net.ipv4.ip_forward=1
modprobe br_netfilter
modprobe bridge

ip link add name br0 type bridge
ip link set br0 up
ip addr add 10.0.0.1/24 dev br0

ip tuntap add mode tap tap0
ip link set tap0 master br0
ip link set tap0 up

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -j RETURN
