# This scripts setups a remote server for Ansible.
# It creates a new Ansible user, adds to sudoers and upload ssh key.

# Important: on Linux run following command to remove /r special characters from Windows
# sed -i 's/\r$//' setup_ansible_user.sh

# One mandatory parameter: hostname or IP address of the remote server

ansible-playbook setup_ansible_user.yml -l "$1", --extra-vars "ansible_user=root" --ask-pass -v

# ansible-playbook setup_ansible_user.yml -l node4, --extra-vars "ansible_user=root ansible_password=password" -v

# ansible-playbook setup_ansible_user.yml -l node4, --extra-vars "ansible_user=root" --ask-pass -v
