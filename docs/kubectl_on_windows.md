# Kubecetl on Windows
During deployment, we used the Administrator workstation for managing the Kubernetes environment. But you can launch Kubernetes commands from any other workstation. All you need is to install kubectl and connectivity to Kubernetes Master Node (to Kubernetes API server) via port 6443.
Here is how you can install kubectl on your Windows workstation.

- Download kubectl binary for Windows from the official source: https://kubernetes.io/docs/tasks/tools/install-kubectl/
For example: https://dl.k8s.io/release/v1.20.0/bin/windows/amd64/kubectl.exe
- Create a dedicated directory (for example, `C:\kube`) and store `kubectl.exe` in it.
- Start `kubectl.exe` for the first time. It will create a folder in your Windows user home directory (example: `C:\Users\User\.kube`)
- Now, you have to copy the Ansible config document from the Master Node to your Windows workstation. On the Master Node, it is stored in directory `$HOME/.kube/config` for _ansible_ user.\
You can use these commands to pull config file from remote Master Node to `.kube` directory on your local workstation:

  `cd C:\Users\User\.kube`

  `scp ansible@192.168.10.140:/home/ansible/.kube/config C:\Users\User\.kube\config`

  (IP address is the address of Master Node)
- Now check whether it works (you must be able to open port 6443 on the Master Node from your workstation):

  `cd C:\kube`

  `kubectl cluster-info`
```
  Kubernetes control plane is running at https://192.168.10.140:6443
  KubeDNS is running at https://192.168.10.140:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```


- Get list of nodes in the Kubernetes cluster:

  `kubectl get nodes`
```
  NAME                 STATUS   ROLES                  AGE   VERSION
  master.example.com   Ready    control-plane,master   46h   v1.20.1
  node1.example.com    Ready    <none>                 46h   v1.20.1
  node2.example.com    Ready    <none>                 45h   v1.20.1
```
