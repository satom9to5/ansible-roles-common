#!/bin/bash

IS_PJ_SETUP=0
[ -n "$1" ] && IS_PJ_SETUP=1

if ! [ `which ansible` ]; then
  REDHAT_MAJOR_VERSION=$(awk '{ print $4 }' /etc/redhat-release | cut -d '.' -f1 )
  case "$REDHAT_MAJOR_VERSION" in
    6)
      wget http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
      sudo rpm --import RPM-GPG-KEY-EPEL-6
      sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
      ;;
    7)
      sudo yum install -y epel-release
      ;;
  esac

  sudo yum install -y ansible
fi

ANSIBLE_BASE_DIR=/vagrant/ansible
#ANSIBLE_BASE_DIR=/vagrant_shared/github_myrepo/ansible-playbook

# ansible inventory file is disable of x permission.
# because permission of virtualbox shared folder is 777, copy inventory file to tmp directory.
mkdir -p /tmp/ansible
cp ${ANSIBLE_BASE_DIR}/localhost /tmp/ansible/localhost
chmod -x /tmp/ansible/localhost

echo "Running Ansible"
ansible-playbook -i /tmp/ansible/localhost ${ANSIBLE_BASE_DIR}/pj_setup.yml
ansible-playbook ${ANSIBLE_BASE_DIR}/docker.yml

if [ $IS_PJ_SETUP -gt 0 ]; then
  ansible-playbook -i /tmp/ansible/localhost ${ANSIBLE_BASE_DIR}/pj_env_setup.yml
  USERNAME=$(grep -P '^pj_name:' ${ANSIBLE_BASE_DIR}/group_vars/localhost | awk '{ print $2 }')
  sudo -u ${USERNAME} ansible-playbook -i /tmp/ansible/localhost ${ANSIBLE_BASE_DIR}/local_user.yml
fi

# root user
ansible-playbook -i /tmp/ansible/localhost ${ANSIBLE_BASE_DIR}/local_user.yml
# by vagrant user
sudo -u vagrant ansible-playbook -i /tmp/ansible/localhost ${ANSIBLE_BASE_DIR}/local_user.yml

rm -f /tmp/ansible/localhost
