#!/bin/bash

USERNAME=$1

if ! [ `which ansible` ]; then
  wget http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
  sudo rpm --import RPM-GPG-KEY-EPEL-6
  sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  sudo yum install -y ansible
fi
 
echo "Running Ansible"
ansible-playbook /vagrant/ansible/proj_name_setup.yml
ansible-playbook /vagrant/ansible/proj_name_env_setup.yml
ansible-playbook /vagrant/ansible/docker.yml
sudo -u ${USERNAME} ansible-playbook /vagrant/ansible/local_user.yml

