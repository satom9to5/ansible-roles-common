#!/bin/bash

if ! [ `which ansible` ]; then
  wget http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
  sudo rpm --import RPM-GPG-KEY-EPEL-6
  sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  sudo yum install -y ansible
fi

ANSIBLE_BASE_DIR=/vagrant/ansible

# ansible inventory file is disable of x permission.
# because permission of virtualbox shared folder is 777, copy inventory file to tmp directory.
mkdir -p /tmp/ansible
cp ${ANSIBLE_BASE_DIR}/localhost /tmp/ansible/localhost
chmod -x /tmp/ansible/localhost

echo "Running Ansible"
ansible-playbook -i /tmp/ansible/localhost ${ANSIBLE_BASE_DIR}/pj_setup.yml
ansible-playbook -i /tmp/ansible/localhost ${ANSIBLE_BASE_DIR}/pj_env_setup.yml
ansible-playbook ${ANSIBLE_BASE_DIR}/docker.yml

rm -f /tmp/ansible/localhost

USERNAME=$(grep -P '^pj_name:' ${ANSIBLE_BASE_DIR}/group_vars/localhost | awk '{ print $2 }')
sudo -u ${USERNAME} ansible-playbook ${ANSIBLE_BASE_DIR}/local_user.yml
