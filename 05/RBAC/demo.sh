kubectl create ns demo
kubectl -n demo create sa demo
kubectl apply -f role.yaml
kubectl -n demo get pods
kubectl -n demo logs demo-pod

kubectl apply -f rolebinding.yaml
kubectl apply -f pod.yaml
kubectl -n demo get pods
kubectl -n demo logs demo-pod
