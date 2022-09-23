# Text Book Example
```sh
$ mkdir cert && cd cert
$ openssl genrsa -out johndoe.key 2048
Generating RSA private key, 2048 bit long modulus
...................................+++
...........................+++
$ openssl req -new -key johndoe.key -out johndoe.csr -subj "/CN=johndoe/O=group1"
$ openssl x509 -req -in johndoe.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out johndoe.crt -days 500
Signature ok
subject=/CN=johndoe/O=group1
Getting CA Private Key
```
# Real Life Example
```sh
mkdir cert && cd cert
openssl genrsa -out jknott.key 2048
openssl req -new -key jknott.key -out jknott.csr -subj "/CN=jknott/O=DevOps"
openssl x509 -req -in jknott.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out jknott.crt -days 5000
kubectl config set-credentials jknott --client-certificate=jknott.crt --client-key=jknott.key
```
# Do not create/edit yamls during the test. It takes too long
```sh
kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods --namespace=ns1
kubectl create rolebinding jknott-pod-reader --role=pod-reader --user=jknott --namespace=ns1
kubectl get pods -n ns1 --as=jknott
```

# Test
```sh
kubectl auth can-i get pods --as jknott --namespace ns1
Yes
```
