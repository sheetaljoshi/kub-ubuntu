#!/bin/sh

kubeadm init --pod-network-cidr=10.244.0.0/16

cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint nodes --all node-role.kubernetes.io/master-
