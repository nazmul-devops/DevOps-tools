# Cluster Creation with `eksctl`
check a ckuster

```sh
eksctl get cluster [--name=<name>][--region=<region>]

eksctl get cluster --name=inneed-cluster --region=ap-south-1 
```

create rsa key

```sh
ssh-keygen
# set location /home/ashik/.ssh/inneedc-cluster
```

this will create a `inneedc-cluster` and `inneedc-cluster.pub` key.

then proceed to create cluster.

```sh
eksctl create cluster \
--name inneed \
--version 1.26 \
--region ap-south-1 \
--nodegroup-name inneed-node \
--node-type t2.small \
--nodes 2 \
--nodes-min 1 \
--nodes-max 5 \
--ssh-access \
--ssh-public-key=~/.ssh/inneed-cluster.pub  \
# --enable-ssm \
--node-volume-size=40 \
--node-volume-type=gp3 \
--spot \
--dry-run
```

to delete cluster

```sh
eksctl delete cluster --name=inneed --region=ap-south-1

eksctl delete cluster -f cluster.yaml  
```

But better if we use a config file to creat ea cluster. as `IAC` it will save a log.

First test the config file is everything is okay.

```sh
eksctl create cluster -f cluster.yaml --dry-run
```

then apply this.

```sh
eksctl create cluster -f cluster.yaml
```

a demo config  file is bellow.

```sh
# cluster.yaml
---
apiVersion: eksctl.io/v1alpha5
# availabilityZones:
#   - us-east-1e
#   - us-east-1d
cloudWatch:
  clusterLogging: {}
iam:
  vpcResourceControllerPolicy: true
  withOIDC: false
kind: ClusterConfig
kubernetesNetworkConfig:
  ipFamily: IPv4
managedNodeGroups:
  - amiFamily: AmazonLinux2
    desiredCapacity: 2
    disableIMDSv1: false
    disablePodIMDS: false
    iam:
      withAddonPolicies:
        albIngress: true
        appMesh: false
        appMeshPreview: false
        autoScaler: true
        awsLoadBalancerController: false
        certManager: true
        cloudWatch: false
        ebs: false
        efs: false
        externalDNS: false
        fsx: false
        imageBuilder: false
        xRay: false
    instanceSelector: {}
    # instanceType: t2.small
    instanceTypes:
      ["t2.medium", "t3.medium", "t2.small", "t3.small", "t3a.small"]
    # taints:
    #   feaster: "true:NoSchedule"
    #   # key: feaster
    #   # value: "true"
    #   # effect: NoSchedule
    propagateASGTags: true
    labels:
      alpha.eksctl.io/cluster-name: inneed
      alpha.eksctl.io/nodegroup-name: inneed-node
      # label-forscaling: inneed-label
    maxSize: 5
    minSize: 1
    name: inneed-node
    # instancesDistribution:
    #   maxPrice: 0.02
    #   instanceTypes: [
    #       "t2.small",
    #       "t2.medium",
    #       "t3.medium",
    #       "t3.small",
    #       "t3a.small",
    #     ] # At least one instance type should be specified
    #   onDemandBaseCapacity: 0
    #   onDemandPercentageAboveBaseCapacity: 50
    #   spotInstancePools: 10

    privateNetworking: false
    releaseVersion: ""
    securityGroups:
      withLocal: null
      withShared: null
    spot: true
    ssh:
      allow: true
      # enableSsm: true
      publicKeyPath: ~/.ssh/inneed-cluster.pub
    tags:
      alpha.eksctl.io/nodegroup-name: inneed-node
      alpha.eksctl.io/nodegroup-type: managed
      nodegroup-role: worker
      # k8s.io/cluster-autoscaler/node-template/label/label-forscaling: inneed-label
      # k8s.io/cluster-autoscaler/node-template/taint/feaster: "true:NoSchedule"
    volumeIOPS: 3000
    volumeSize: 80
    volumeThroughput: 125
    volumeType: gp3
metadata:
  name: inneed
  region: ap-south-1
  version: "1.26"
privateCluster:
  enabled: false
  skipEndpointCreation: false
vpc:
  autoAllocateIPv6: false
  cidr: 192.168.0.0/16
  clusterEndpoints:
    privateAccess: false
    publicAccess: true
  manageSharedNodeSecurityGroupRules: true
  nat:
    gateway: Single
```

update kube config to connect to eks

```sh
aws eks update-kubeconfig --name <cluster-name>

 #if default region is different region then :
aws eks update-kubeconfig --name inneed --region ap-south-1
```

if it's needed to scale number of nodes:

```sh
eksctl scale nodegroup --name=inneed-node --cluster=inneed --nodes=3 --nodes-min=2 --nodes-max=5 --region ap-south-1
```
it may take some times to create and attach nodes to existing cluster.