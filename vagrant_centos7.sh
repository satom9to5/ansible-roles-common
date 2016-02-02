#!/bin/bash

if ! [ `which ansible` ]; then
  sudo yum install -y epel-release
  sudo yum install -y ansible
fi

ANSIBLE_BASE_DIR=/vagrant_shared/github_myrepo/ansible-playbook

# ansible inventory file is disable of x permission.
# because permission of virtualbox shared folder is 777, copy inventory file to tmp directory.
mkdir -p /tmp/ansible
cp ${ANSIBLE_BASE_DIR}/localhost /tmp/ansible/localhost
chmod -x /tmp/ansible/localhost

echo "Running Ansible"
ansible-playbook -i /tmp/ansible/localhost ${ANSIBLE_BASE_DIR}/pj_setup.yml
ansible-playbook ${ANSIBLE_BASE_DIR}/docker.yml

rm -f /tmp/ansible/localhost

USERNAME=$(grep -P '^pj_name:' ${ANSIBLE_BASE_DIR}/group_vars/localhost | awk '{ print $2 }')
sudo -u ${USERNAME} ansible-playbook ${ANSIBLE_BASE_DIR}/local_user.yml

# by vagrant user
ansible-playbook ${ANSIBLE_BASE_DIR}/local_user.yml
