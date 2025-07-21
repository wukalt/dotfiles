#!/bin/bash

# Change dns 
# /etc/resolve.conf -> will be changed
# 
# thanks to: shecan -> site: https://shecan.ir

echo -e "nameserver 178.22.122.100\nnameserver 185.51.200.2" | sudo tee /etc/resolv.conf
echo "Done."
