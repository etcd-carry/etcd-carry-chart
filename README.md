# helm-chart

charts repository url: https://etcd-carry.github.io/helm-chart/
1. add etcd-carry charts repository if you haven't do this:
```shell
$ helm repo add etcd-carry https://etcd-carry.github.io/helm-chart/
```
2. add repo successfully
```shell
$ helm repo list
NAME      	URL                                     
etcd-carry	https://etcd-carry.github.io/helm-chart/
```
3. search the charts
```shell
$ helm search repo
NAME                 	CHART VERSION	APP VERSION	DESCRIPTION                
etcd-carry/etcd-carry	0.2.0        	v0.2.0     	A Helm chart for Kubernetes
```
4. install with helm
```shell
$ helm install etcd-carry etcd-carry/etcd-carry --version 0.2.0
```
