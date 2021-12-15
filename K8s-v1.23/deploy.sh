#!/bin/bash

set -xe

echo Deploying Kubernetes
sudo kubeadm init --config=./onprem1230.yaml 

echo Setting Credentials for kubectl access
mkdir -p $HOME/.kube
sudo -H cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo -H chown $(id -u):$(id -g) $HOME/.kube/config

#kubectl taint nodes --all node-role.kubernetes.io/master-

sleep 5

echo Deploying Calico 3.14 CNI
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo Deploying metallb 0.11.0 bare metal load balancer provider
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml
