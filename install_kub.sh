apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update

apt-get install -y docker.io
apt install kubelet=1.8.0-00
apt-get install -y kubeadm kubectl

# 1.5.6 does exist in the repo but it has a hard depenedency on a newer kubernetes-cni.  Use 1.5.3 instead.
# sudo apt-get -y install kubectl=1.5.3-00 kubelet=1.5.3-00 kubernetes-cni=0.3.0.1-07a8a2-00

# Versioning strangeness for how we packaged kubeadm pre-1.6 means that the version number
# says 1.6.0-alpha even though it is the 1.5 version of kubeadm.  Because of how this sorts,
# we cannot keep this deb in the repo.  Download it manually and install it.
# curl -Lo /tmp/old-kubeadm.deb https://apt.k8s.io/pool/kubeadm_1.6.0-alpha.0.2074-a092d8e0f95f52-00_amd64_0206dba536f698b5777c7d210444a8ace18f48e045ab78687327631c6c694f42.deb
# sudo dpkg -i /tmp/old-kubeadm.deb
# apt-get install -f

# Hold these packages back so that we don't accidentally upgrade them.
# sudo apt-mark hold kubeadm kubectl kubelet kubernetes-cni

swapoff -a
sed -i '/ swap /s/^/#/' /etc/fstab



exit

kubeadm init --kubernetes-version v1.8.0
mkdir -p $HOME/.kube

cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
export kubever=$(kubectl version | base64 | tr -d '\n')

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"
