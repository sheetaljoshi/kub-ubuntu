export kubever=$(kubectl version | base64 | tr -d '\n')

wget -O kube-weave.yaml  "https://cloud.weave.works/k8s/net?k8s-version=$kubever"
~
