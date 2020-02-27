#!/bin/bash

set -xe

echo Deploying Kubernetes
sudo kubeadm init --config=$HOME/onprem-v17.yaml 

echo Setting Credentials for kubectl access
mkdir -p $HOME/.kube
sudo -H cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo -H chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint nodes --all node-role.kubernetes.io/master-

sleep 5

# https://docs.projectcalico.org/v3.7/getting-started/kubernetes/installation/calico
# As we are running AIO (or at most 3 nodes in my lab) - I am using the 50
# nodes or less installation method

echo Deploying Calico 3.8 CNI
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

# https://metallb.universe.tf/installation/
# Ensure the IP address range in configmap-073.yaml is reserved
# by your firewall/router, and are part of the POD subnet.

echo Deploying metallb 0.7.3 bare metal load balancer provider
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.3/manifests/metallb.yaml
kubectl apply -f $HOME/metallb-configmap-083.yaml

echo Please use kubeadm on any extra nodes you wish in your cluster.
echo wait for all Kubernetes nodes to enter the "Ready" state.
echo Finally deploy Istio.
