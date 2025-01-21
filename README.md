# About  
This project used to introduce the following things:  
- How to create your Kubernetes cluster.
- How to deploy your backend server on a Kubernetes cluster.
- How to design the network.
- How to design the pod scheduling.

# Create your Kubernetes Cluster  

## Bootstrapping cluster with kubeadm
Follow the instructions on https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/ to create your Kubernetes cluster step by step.  

The general steps:
- Install Docker Engine.  
Docs: https://docs.docker.com/engine/install/ubuntu/

- Install CRI-Dockerd.  
Docs: https://www.mirantis.com/blog/how-to-install-cri-dockerd-and-migrate-nodes-from-dockershim/  
Follow the step to enable cri-dockerd in systemd is enough. 

- Install the kubeadm.  
Docs: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

- Init the kubeadm.(For Kubernetes master)  
Docs: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/   
In this step, you need to specify the `--pod-network-cidr` argument which will be used to adapt to the network setup. (as https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart#create-a-single-host-kubernetes-cluster)  
And the `--cri-socket` argument expecially when you are using cri-dockerd.

- Join Kubernetes cluster.(For Kubernetes nodes)  
Use `kubeadm join` command to join the cluster.  
Commands:  
    ```
    kubeadm join <master-ip>:<master-port> --token <master-token> --discovery-token-ca-cert-hash sha256:<sha256> --cri-socket unix:///var/run/cri-dockerd.sock
    ```

- The network setup.  
You can pick one network plugins following the CNI (Container Network Interface).  
Docs(Calico): https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart#create-a-single-host-kubernetes-cluster  

# Use Helm to Manage your Package
## Install Helm
Docs: https://helm.sh/docs/intro/install/  

## Install Kubernetes Dashboard
Docs: https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/  
You can use helm to install the Kubernetes Dashboard now.  
You may need to update the `kubernetes-dashboard-kong-proxy` to `NodeType` so that you can access the dashboard. Also you need to create a service account.  
Commands:  
```
# Update service.

kubectl -n kubernetes-dashboard edit service kubernetes-dashboard-kong-proxy


# Create service account.

kubectl create serviceaccount dashboard-admin -n kubernetes-dashboard

kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceacount=kubernetes-dashboard:dashboard-admin

kubectl create token dashboard-admin -n kubernetes-dashboard
```

## Install Your Backend Release

Steps:
- Build your docker image from a Dockerfile.  
Commands:
    ```
    docker build --platform=linux/amd64 -t <docker-username>/<docker-repo> .
    ```  

- Push your image to registry.  
Commands:
    ```
    docker push <docker-username>/<docker-repo>
    ```

- Create helm chart for your project.  
Commands:
    ```
    helm create <chart-name>
    ```

- Update the helm files  
Docs: https://helm.sh/docs/chart_template_guide/yaml_techniques/  
In addition to YAML syntax, you should also know how to use helm.

- Create secret for your Kubernetes namespace.(For private repo)  
Commands:
    ```
    kubectl create secret docker-registry <secret-name> \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<docker-username> \
    --docker-password=<docker-password> \
    --docker-email=<docker-email> \
    --namespace=<your-namespace>
    ```

- Helm install/uninstall/upgrade the release  
Commands:
    ```
    helm install <release-name> <chart-folder>
    ```
