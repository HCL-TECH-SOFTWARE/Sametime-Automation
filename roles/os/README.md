ANSIBLE ROLE
------------

# os
Basic Linux OS configuration


Role Variables
--------------
## main

*Basic Linux OS configuration*

This is the main entrypoint for the role.

It does the basic Linux configration:

Hostname, packages update, SELinux, firewall.

| Variable | Description | Type | Required | Default |
| -------- | ----------- | ---- | -------- | ------- |
| os__disable_firewall | Enable/Disable system firewall in OS. `True` = Disable firewall. `False` = Enable firewall and add defined rules. The current version of Sametime script was tested only with "true", which means firewall is disabled. | bool | no | False |
| os__selinux | Configure SELinux. Options: `enforcing`, `permissive`, `disabled`. | str | no | enforcing |
| os__set_hostname | Related to os__set_hostname parameter. `True` = server hostname will be set using a hostname Linux command.  `False` = no changes will be made. | bool | no | False |
| os__set_etc_hosts | Related to os__set_hostname parameter. `True` = server hostname will be stored in /etc/hosts, resolving to 192.168.0.1.  `False` = no changes will be made. | bool | no | False |
| os__hostname | Server hostname; if not specified, ansible_host from Ansible inventory is used. Related to *os__set_hostname* and *os__set_etc_hosts* parameters. | str | no | none |


Dependencies
------------
None.

Example Playbook
----------------
```
- hosts: all
  tasks:
    - name: Importing role: os
      ansible.builtin.import_role:
        name: os
      vars:
        
```


License
-------
Apache License 2.0


Author Information
------------------
Petr Kunc @ HCLSoftware
