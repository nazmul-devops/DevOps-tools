---
sidebar: auto
---
# Kubernetes Tutorial

**_By: Nazmul Islam - Junior DevOps Engineer_**

## What is Kubernetes?

Kubernetes (often abbreviated as "K8s") is an open-source system for automating the deployment, scaling, and
management of containerized applications. It provides a way to manage multiple containers as a single unit, making it easier to deploy, scale, and manage applications in a microservices architecture.

Kubernetes was originally developed by Google, and is now maintained by the Cloud Native Computing Foundation (CNCF). It is widely adopted and has become the de facto standard for managing containerized applications in production.

## Why we should use Kubernetes?

There are several reasons why organizations choose to use Kubernetes:

1. High Availability: We can deploy any changes to kubernetes with no downtime.

2. Scalability: Kubernetes makes it easy to horizontally scale applications by adding or removing replicas of a container as needed.

3. Resilience: Kubernetes can automatically recover from failures by replacing failed containers and ensuring that the desired number of replicas is maintained.

4. Load balancing: Kubernetes can automatically distribute incoming traffic across multiple replicas of a container to ensure that no single replica becomes a bottleneck.

5. Portability: Kubernetes allows applications to run on different cloud platforms, as well as on-premises, making it easier to deploy applications in different environments.

6. Ease of deployment: Kubernetes provides a unified way to define, deploy, and manage applications, making it easier to roll out updates and rollbacks.

Overall, Kubernetes helps organizations to build, deploy, and manage large-scale, complex applications more efficiently and effectively.

## Kubernetes Main Components & Architechture:

Kubernetes is an open-source platform for automating deployment, scaling, and management of containerized applications. The following are the main components of a Kubernetes system:

1. Master node: The Master node is the brain of a Kubernetes cluster and it is responsible for the overall management of the cluster. It exposes the Kubernetes API, and it contains the following components:

- kube-apiserver: Exposes the Kubernetes API.

- etcd: Distributed key-value store for storing the configuration data.
- kube-controller-manager: Handles the state of the cluster, such as replication controllers and endpoints.
- kube-scheduler: Assigns work to nodes.

2. Worker node: Worker nodes are where containers are deployed and run. A worker node contains the following components:

- kubelet: Communicates with the Master node and makes sure that containers are running as expected.
- kube-proxy: Acts as a network proxy and load balancer for service requests.
- container run time: we can use any container run time environment like docker or containerd

3. Pods: Pods are the smallest and simplest unit in the Kubernetes object model, and they represent a single instance of a running process in your cluster. Pods contain one or more containers, and they provide shared network and storage resources for those containers.

4. Containers: The applications you want to run are packaged into containers, which are lightweight, stand-alone, and executable packages of software that include everything needed to run the application (code, runtime, system tools, libraries, etc.).

5. Volumes: Volumes are a way to persist data in your cluster, even if a pod is deleted or recreated. They provide a way to store data on disk or in the cloud, and mount that data into your pods.

6. Services: Services are used to expose your application to the network, allowing it to be accessible from outside the cluster. Services can load balance incoming traffic to multiple pods.

7. Replication Controller: Replication controllers are used to ensure that a specified number of replicas of a pod are running at all times. If a pod goes down, the replication controller will create a new replica to replace it.

8. Deployments: Deployments are higher-level objects that manage replicas and provide declarative updates for your applications. You define your desired state in a deployment, and the deployment controller changes the actual state to the desired state.

9. ConfigMaps and Secrets: ConfigMaps and Secrets are used to store configuration data and secrets, respectively, for your applications. They can be used to store database passwords, API keys, and other sensitive information.

10. Ingress: Kubernetes Ingress is a collection of routing rules that govern how external users access services running inside a Kubernetes cluster. It provides a way to expose HTTP and HTTPS routes from outside the cluster to services within the cluster.

An Ingress resource defines how requests to a certain path or host should be routed to a specific service within the cluster. For example, you can define a rule that routes requests to the host "www.example.com" to a service that serves a web application. You can also define multiple rules to route requests to different paths or hosts to different services.

Ingress is typically implemented by deploying an Ingress controller, which is a component that watches the API server for updates to the Ingress resource and implements the routing rules accordingly. The Ingress controller can be any web server that implements the Ingress specification, such as Nginx, Traefik, or Istio.

Ingress provides an easy and efficient way to expose your applications to external users and manage the incoming traffic to your services. It can be used to enforce security policies, such as SSL/TLS encryption, basic authentication, and rate limiting, and to handle tasks such as request redirection and URL rewriting.

These are the main components of a Kubernetes system. Understanding these components is crucial for effectively managing and deploying applications on a Kubernetes cluster.

## Minikube Setup on Local machine

Minikube is a tool that allows you to run a single-node Kubernetes cluster on your local machine. You can also set it up on a remote server. Here's how you can set up Minikube on a server:

1. Install virtualization software: Minikube requires a hypervisor to manage virtual machines. You can use VirtualBox, KVM, or Hyper-V as the hypervisor.

2. Install Minikube: You can download Minikube binary for your operating system from the official Minikube website and install it. You can also install Minikube using a package manager like apt or yum.

3. Start Minikube: To start Minikube, you need to run the following command:

```sh
minikube start --driver=<driver_name>
```

4. Verify the installation: To verify that Minikube is running, you can use the following command:

```sh
minikube status
```

This will give you the status of your Minikube cluster, including the Kubernetes version, the URL of the dashboard, and the state of the cluster.

5. Access the dashboard: To access the Minikube dashboard, you can use the following command:

```sh
minikube dashboard
```

## How to setup a simple 3 (Three) node kubernetes cluster on ubuntu servers on top of proxmox server.

### Prerequisites

To follow along with this tutorial, you’ll need:

At least three Ubuntu Server 22.04 instances (one for the controller, two for worker node)
A static IP address or DHCP reservation on those instances, so their IP addresses cannot change
The controller node should have at least 2GB of RAM and 2 cores
The node instances can have a single gigabyte of RAM and a single CPU core (or more if you prefer)
Note: This tutorial utilizes Ubuntu Server 22.04. If you choose to use a different distribution or a different
version of Ubuntu, these commands may not work.

### Setting up the cluster

The following commands are to be run on the controller/master node (unless otherwise stated).

#### Setting up a static IP

Note, a static lease is preferred, but you can use the following Netplan config example to serve as a basis of
yours if you need to set up a static IP.

```sh
network:
version: 2
ethernets:
eth0:
addresses: [192.168.10.100/24]
nameservers:
addresses: [8.8.8.8]
routes:
  - to: default
  via: 192.168.10.1
```

#### Installing containerd

This Kubernetes cluster will utilize the containerd runtime. To set that up, we’ll first need to install the
required package:

```sh
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Create the initial configuration:

```sh
sudo mkdir /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
```

For this cluster to work properly, we’ll need to enable SystemdCgroup within the configuration. To do that, we’ll
need to edit the config we’ve just created:

```sh
sudo nano /etc/containerd/config.toml
```

Within that file, find the following line of text:

_[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]_

Underneath that, find the SystemdCgroup option and change it to true, which should look like this:

**SystemdCgroup = true**

Disable swap
Kubernetes requires swap to be disabled. To turn off swap, we can run the following command:

```sh
sudo swapoff -a
```

Next, edit the /etc/fstab file and comment out the line that corresponds to swap (if present). This will help
ensure swap doesn’t end up getting turned back on after reboot.

Enable bridging
To enable bridging, we only need to edit one config file:

```sh
sudo nano /etc/sysctl.conf
Within that file, look for the following line:

#net.ipv4.ip_forward=1
Uncomment that line by removing the # symbol in front of it, which should make it look like this:

net.ipv4.ip_forward=1
Enable br_netfilter
```

The next step is to enable br_netfilter by editing yet another config file:

```sh
sudo nano /etc/modules-load.d/k8s.conf
Add the following to that file (the file should actually be empty at first):

br_netfilter
```

Reboot your servers
Reboot each of your instances to ensure all of our changes so far are in place:

```sh
sudo reboot
```

### Installing Kubernetes

The next step is to install the packages that are required for Kubernetes. First, we’ll add the required GPG key:

Update the apt package index and install packages needed to use the Kubernetes apt repository:

```sh
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
```

Download the Google Cloud public signing key:

```sh
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
```

Add the Kubernetes apt repository:

```sh
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:

```sh
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
sudo apt-mark hold kubelet kubeadm kubectl
```

**Controller node only:**
Initialize our Kubernetes cluster
So long as you have everything complete so far, you can initialize the Kubernetes cluster now. Be sure to customize the first IP address shown here (not the second) and also change the name to match the name of your
controller.

```sh
sudo kubeadm init --control-plane-endpoint=172.16.250.216 --node-name
controller --pod-network-cidr=10.244.0.0/16
```

After the initialization finishes, you should see at least four commands printed within the output.

Setting up our user account to manage the cluster
Three commands will be shown in the output from the previous command, and these commands will give our user
account access to manage our cluster. Here are those related commands to save you from having to search the output
for them:

```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
suod chown $(id -u):$(id -g) $HOME/.kube/config
```

Those commands should allow you to manage the cluster, without needing to use the root account to do so.

Install an Overlay Network

The following command will install the Flannel overlay network (an overlay network is required for this to
function).

```sh
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/
Documentation/kube-flannel.yml
```

Adding Nodes
The join command, which you will receive from the output once you initialize the cluster, can be ran on your node
instances now to get them joined to the cluster. The following command will help you monitor which nodes have been
added to the controller (it can take several minutes for them to appear):

If for some reason the join command has expired, the following command will provide you with a new one:

```sh
kubectl get nodes
kubeadm token create --print-join-command
```

Deploying a container within our cluster
Create the file pod.yml with the following contents:

```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-example
  labels:
    app: nginx
spec:
  containers:
    - name: nginx
  image: linuxserver/nginx
  ports:
    - containerPort: 80
  name: "nginx-http"
```

Apply the file with the following command:

```sh
kubectl apply -f pod.yml
```

You can check the status of this deployment with the following command:

```sh
kubectl get pods
```

Creating a NodePort Service
Setting up a NodePort service is one of the methods we can use to be able to access the container from outside the
pod network. To set this up, first create the following file as service-nodeport.yml:

```yml
apiVersion: v1
kind: Service
metadata:
  name: nginx-example
spec:
  type: NodePort
  ports:
    - name: http
  port: 80
  nodePort: 30080
  targetPort: nginx-http
selector:
  app: nginx
```

You can apply that file with the following command:

```sh
kubectl apply -f service-nodeport.yml
```

To check the status of the service deployment, you can use the following command:

```sh
kubectl get services
```

And now, you have your very own Kubernetes cluster, congratulations!

## Install Kubernetes Master Node on Rocky Linux 9.

In this configuration guide, you will learn how to install Kubernetes Master Node on Rocky Linux 9 or other RPM based Linux distros.
Ref: [YouTube Video Link](https://youtu.be/WaAEcyu28BI)

Set Hostname and Name Resolution:
By using a ssh client, connect with your Linux server as root user.

Set a proper FQDN (Fully Qualified Domain Name) for your Kubernetes server. Also use the Local DNS resolver (/etc/hosts) for name resolution of your hostname.

```sh
hostnamectl set-hostname k8s-master-node
echo 192.168.30.110 k8s-master-node >> /etc/hosts
```

#### Updating Rocky Linux Server:

```sh
dnf makecache --refresh
dnf update -y
cat /etc/rocky-release
uname -r
```

#### Switch SELinux to Permissive Mode:

Kubernetes doesn't provide a SELinux policy, therefore you can either switch SELinux target to Permissive mode or manually set the File Context of various Kubernetes files and directories.

For the scope of this article, we recommend that you should set permissive target for SELinux. However, if you are configuring a Kubernetes cluster for production then you should identify the files and set the File Context for them, or you can even create your own SELinux policy.

Execute following commands at Linux bash to set SELinux permissive mode.

```sh
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
```

#### Loading K8s required Kernel Modules:

Kubernetes requires "overlay" and "br_netfilter" Kernel modules. Therefore, you can use following group of commands to permanently enable them.

```sh
modprobe overlay
modprobe br_netfilter
cat > /etc/modules-load.d/k8s.conf << EOF
overlay
br_netfilter
EOF
```

Set following Kernel parameter as required by Kubernetes software.

```sh
cat > /etc/sysctl.d/k8s.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system

```

#### Disable Swap in Linux:

To disable Swap for your current session you can use swapoff command. However, for permanently disable the Swap storage you have to comment (#) the respective directive in /etc/fstab file.

Execute following commands to do the same.

```sh
swapoff -a
sed -e '/swap/s/^/#/g' -i /etc/fstab
free -m
```

#### Install Docker on rockylinux/redhat:

Referance link is: [Rocky Linux Official Docs](https://docs.rockylinux.org/gemstones/docker/#add-the-docker-repository)

## Add the docker repository

Use the `dnf` utility to add the docker repository to your Rocky Linux server. Type:

```sh
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

#### Install the needed packages

Install the latest version of Docker Engine, containerd, and Docker Compose, by running:

```sh
sudo dnf update
sudo dnf makecache
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

#### Start and enable the systemd docker service (dockerd)

Use the `systemctl` utility to configure the dockerd daemon to automatically startup with the next system reboot and simultaneously start it for the current session. Type:

```sh
sudo systemctl --now enable docker
```

#### Notes

```sh
docker-ce               : This package provides the underlying technology for building and running docker containers (dockerd)
docker-ce-cli           : Provides the command line interface (CLI) client docker tool (docker)
containerd.io           : Provides the container runtime (runc)
docker-compose-plugin   : A plugin that provides the 'docker compose' subcommand

```

**some extrea packeges:**

```sh
sudo dnf install epel-release -y
```

After installation, backup the original containerd configuration file and generate a new file as follows.

```sh
mv /etc/containerd/config.toml /etc/containerd/config.toml.orig
containerd config default > /etc/containerd/config.toml
```

Edit Containerd configuration file by using nano text editor.

```sh
nano /etc/containerd/config.toml
```

Locate and set SystemdCgroup parameter in this file, to enable the systemd cgroup driver for Containerd runtime.

```sh
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  ...
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    SystemdCgroup = true
```

Enable and start Containerd service.

```sh
systemctl enable --now containerd.service
systemctl status containerd.service
```

#### Configure Linux Firewall:

Therefore, you need to allow these service ports in Linux firewall.

```sh
firewall-cmd --permanent --add-port={6443,2379,2380,9090,10250,10251,10252}/tcp
firewall-cmd --reload
```

#### Installing Kubernetes Software:

To install Orchestration software, you have to add the Kubernetes Official Yum Repository.

The following command will add the Kubernetes repository in your Linux server.

```sh
cat > /etc/yum.repos.d/k8s.repo << EOF
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF
Build the yum cache for Kubernetes yum repository.
dnf makecache
```

```sh
dnf update -y
dnf install -y {kubelet,kubeadm,kubectl} --disableexcludes=kubernetes
systemctl enable --now kubelet.service
systemctl status kubelet
```

#### Enable Bash Completion for Kubernetes Commands:

```sh
source <(kubectl completion bash)
kubectl completion bash > /etc/bash_completion.d/kubectl
```

#### Installing Flannel CNI Plugin:

Kubernetes supports various CNI (Container Network Interface) plugins, such as AWS VPC, Azure CNI, Cilium, Calico, Flannel, and many more.

In this configuration guide, we are using Flannel CNI plugin. Ensure that this plugin must be installed on each Kubernetes node.

Create a directory and download flanneld file therein.

```sh
mkdir /opt/bin
curl -fsSLo /opt/bin/flanneld https://github.com/flannel-io/flannel/releases/download/v0.20.1/flannel-v0.20.1-linux-amd64.tar.gz
```

Grant execution permissions to flanneld file to make it an executable.

```sh
chmod +x /opt/bin/flanneld
```

#### Initializing Kubernetes Control Plane:

Execute the following command to download container images, that are required to create Kubernetes Cluster.

```sh
kubeadm config images pull
kubeadm init
```

Note down the command to add Kubernetes Worker node for later use.

Execute following command to set KUBECONFIG variable for all sessions.

```sh
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /etc/profile.d/k8s.sh
```

Execute following commands as a user, that is being used to manage your Kubernetes cluster.

```sh
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

Execute kubectl commands to check the status of your Kubernetes cluster.

```sh
kubectl get nodes
kubectl cluster-info
```

After Kubernetes Control Plane is started, run the following command to install the Flannel Pod network plugin. This command will automatically run the "flanneld" binary file and start some flannel pods.

```sh
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

Check the list of running pods on your Kubernetes cluster.

```sh
kubectl get pods --all-namespaces
```

**Congratulations! Your kubernetes master node has been installed successfully.**

## Kubectl commands

Here are some of the most commonly used Kubernetes commands written in raw markdown code:

### Basic Commands

`kubectl create` - Create a resource from a file or stdin
`kubectl apply` - Apply a configuration to a resource by filename or stdin
`kubectl get` - Display one or many resources
`kubectl describe` - Show details of a specific resource or group of resources
`kubectl delete` - Delete resources by filenames, stdin, resources and names, or by resources and label selector

### Pod Management

`kubectl run` - Create a new deployment or job with a pod template
`kubectl expose` - Expose a deployment, replica set, or replication controller as a service
`kubectl port-forward` - Forward one or more local ports to a pod
`kubectl logs` - Print the logs for a container in a pod

### Deployment Management

`kubectl rollout` - Manage the rollout of a resource
`kubectl scale` - Set a new size for a deployment, replica set, or replication controller
`kubectl autoscale` - Auto-scale a deployment, replica set, or replication controller based on resource usage
`kubectl update` - Update a deployment, replica set, or replication controller to a new version

### Cluster Management

`kubectl config` - Modify kubeconfig files
`kubectl cluster-info` - Display cluster information
`kubectl top` - Display Resource (CPU/Memory/Storage) usage
`kubectl version` - Display the Kubernetes version running on the client and server

These are just a few examples of commonly used Kubernetes commands. For a full list of available commands, you can refer to the official Kubernetes documentation.
