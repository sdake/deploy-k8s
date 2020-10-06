# Deploy Containerd, Kubernetes, Calico, MetalLB for development ONLY

## Overview

This is not a deployment project, but simply my tooling for doing development work.
I don't feel the world needs yet another K8s deployment system, however, I need
something simple and understandable for my own development which involves
contribution to [Istio project](https://istio.io) and the cloud native ecosystem. I
wrote the Ansible code in about an hour so its not great, and is probably buggy.
If you submit PRs to fix bugs, I will accept them. PRs for features may not be
accepted. Please slack me if you are thinking of adding anything complex, so you
don't waste your time :)

This code deploys the following:
- containerd
- Kubernetes
- Calico
- MetalLB

Please read the license. There is ABSOLUTELY NO WARRANTY. If you run these playbooks
on an existing cluster, they may eat your system.

## Directory Layout

| Directory | Purpose
|-----------|--------
| K8s-v1.14 | deploy K8s v1.14 with kubeadm AIO
| K8s-v1.17 | deploy K8s v1.17 with kubeadm AIO
| K8s-v1.18 | deploy K8s v1.18 with kubeadm AIO
| K8s-v1.19 | deploy K8s v1.19 with kubeadm AIO
| ansible   | Deploy a control plane and a bunch of workers using an ansible playbook with kubeadm

## Using Ansible

### Prereqs

- Ensure you have passwordless sudo setup on every node in your inventory.
- Do not run as user root.
- Instead run as your local user.
- Ensure containerd 1.3.3 or later is installed. This tooling does not depend on Docker, only containerd from ubuntu. You may be able to install containerd with ansible-playbook -f setup-containerd.yml. This may or may not work. I have not done a final validation of my system from initial deployment to determine if the code is correct.

### Usage

1. Copy the yaml files form the `K8s-v1.y` directory to your home directory.
1. Modify the inventory with the ip addresses of your machines.
1. Modify the advertise address to your control plane IP address in `onprem-1y.yaml`.
1. Run the `do.sh` script with `-c create` or `-c destroy`.

**DO OR DO NOT**
