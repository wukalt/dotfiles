#!/bin/bash

echo "nameserver 185.51.200.2" | sudo tee /etc/resolv.conf
echo "nameserver 178.22.122.100" | sudo tee -a /etc/resolv.conf
