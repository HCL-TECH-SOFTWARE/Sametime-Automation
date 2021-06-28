# Stages

The main Ansible script is divided into several stages. They have to be applied all and in the defined order.
You can go to the next stage only when you successfully completed the previous stage.
You can launch one stage multiple times, so if an error occurs, you can locate the cause, fix it and re-run the stage again.

## The main script - All at once
If you run the main playbook `main.yml`, it will run all stages at once, from the first ones (checking and preparing the environment) to the last one (final Sametime Meetings installation).\
It is fully unattended; you can sit and watch. If stops only if an error occurs. When you run `main.yml` after that, it will start from the very first stage again.\
It does not affect the final result, but if you are stuck on some stage, you would appreciate re-running the script only for this specific part, not from the very beginning.

That's why we labeled all stages with tags, and you can start any stage individually.
> **Note:** The condition that each stage can run only when all previous stages finished successfully remains valid. You can jump directly to stage 5, but it will fail if you did not finish stages 1-4.

## List of stages

Stage Name | Description
--|--
check-environment  |  Checks if parameters in `vars.yml` are set up correctly
print-server-info  |  Prints HW and OS info for each node
prepare-server  |  Configure the operating system for Kubernetes install
docker-install  |  Installs Docker
kubernetes-install  |  Installs and sets up Kubernetes cluster
prepare-install-package  |  Uploads and unpacks installation packages to each node
kubernetes-addons-install  |  Installs and configures necessary Kubernetes add-ons
sametime-install  |  Installs Sametime Meetings
print-summary  |  Prints the final summary: hostnames, logins, and passwords

Stages are represented as _roles_ in the Ansible script. Check `main.yml` in the root folder.

## Run only the selected stage

Use the following commands to run only one selected stage. If you run all of them, it is the same as you would run `main.yml` without any parameters (all at once).

"-v" at the end of the command means that you want verbose output. You can remove it if you want, but we expect that if you plan to run only one specific stage, you probably do some testing/fixing so that the detailed output would be handy.

```
ansible-playbook main.yml --tags "check-environment" -v
ansible-playbook main.yml --tags "print-server-info" -v
ansible-playbook main.yml --tags "prepare-server" -v
ansible-playbook main.yml --tags "docker-install" -v
ansible-playbook main.yml --tags "kubernetes-install" -v
ansible-playbook main.yml --tags "prepare-install-package" -v
ansible-playbook main.yml --tags "kubernetes-addons-install" -v
ansible-playbook main.yml --tags "sametime-install" -v
ansible-playbook main.yml --tags "print-summary" -v
```

### Kubernetes Add-ons sub-stages
The stage kubernetes-addons-install is the most complex one; it prepares and installs all Kubernetes extensions like Dashboard, Elasticsearch, Grafana, etc. Therefore we also labeled each part in the stage, so you can run only this sub-stage if you are fixing a problem in Ingress, for example.\
Run the following commands if you want to run only a selected sub-stage in the stage **kubernetes-addons-install**.

Sub-stage Name | Description
--|--
helm  |  Package manager for Kubernetes
certmgr  |  Issues Let's Encrypt certificates
ingress  |  Provides external access to Kubernetes services
dashboard  |  Web-based interface to Kubernetes environment
efk  |  Logging stack: Elasticsearch, Filebeat, Kibana
prometheus  |  Monitoring stack: Promatheus, Grafana

```
ansible-playbook main.yml --tags "kubernetes-addons-install" --skip-tags "certmgr, ingress, dashboard, efk, prometheus" -v
ansible-playbook main.yml --tags "kubernetes-addons-install" --skip-tags "helm, ingress, dashboard, efk, prometheus" -v
ansible-playbook main.yml --tags "kubernetes-addons-install" --skip-tags "helm, certmgr, dashboard, efk, prometheus" -v
ansible-playbook main.yml --tags "kubernetes-addons-install" --skip-tags "helm, certmgr, ingress, efk, prometheus" -v
ansible-playbook main.yml --tags "kubernetes-addons-install" --skip-tags "helm, certmgr, ingress, dashboard, prometheus" -v
ansible-playbook main.yml --tags "kubernetes-addons-install" --skip-tags "helm, certmgr, ingress, dashboard, efk" -v
```
> **Note:** As you see, for sub-stages we use a negative selection (`--skip-tags`), so you remove the tag you want to perform.
