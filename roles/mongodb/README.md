ANSIBLE ROLE
------------

# mongodb
MongoDB installation


Role Variables
--------------
## main

*MongoDB installation*

Install MongoDB for usage with HCL Sametime.

Provides single node installation, for demo or test purposes.

Focuses on simplicity.

| Variable | Description | Type | Required | Default |
| -------- | ----------- | ---- | -------- | ------- |
| mongodb__install | Location of MongoDB install files. | str | no | /local/install/mongo |
| mongodb__data | Location of MongoDB data files. Databases will be stored in this directory. | str | no | /local/mongo/data/db |
| mongodb__container | Name of the MongoDB container. | str | no | mongo |
| mongodb__sametime_network | Name of the Docker network. Should be the same as the network used by Sametime containers. Parameter sametime_docker__mongodb_in_local_container=true requires that MongoDB and Sametime use the same Docker network. | str | no | sametime.test |


Dependencies
------------
None.

Example Playbook
----------------
```
- hosts: all
  tasks:
    - name: Importing role: mongodb
      ansible.builtin.import_role:
        name: mongodb
      vars:
        
```


License
-------
Apache License 2.0


Author Information
------------------
Petr Kunc @ HCLSoftware
