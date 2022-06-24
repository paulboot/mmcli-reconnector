ip route del default dev wwan0
ip route add default via 192.168.3.1 dev eth0 metric 20
