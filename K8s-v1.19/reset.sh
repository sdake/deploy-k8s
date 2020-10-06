#!/bin/bash

sudo kubeadm reset --skip-phases preflight,update-cluster-status,remove-etcd-member
sudo rm -rf /var/lib/etcd
sudo iptables -F
