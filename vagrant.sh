#!/bin/bash

if ! [ `which ansible` ]; then
  wget http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
  sudo rpm --import RPM-GPG-KEY-EPEL-6
  sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  sudo yum install -y ansible
fi

# 実行権限が付与されているとansible-playbookで失敗する＆共有フォルダにファイルが存在していて実行権限を落とせないケースがあるため、
# cpして実行権限を落とす
mkdir -p /tmp/ansible
cp /vagrant/ansible/localhost /tmp/ansible/localhost
chmod -x /tmp/ansible/localhost

echo "Running Ansible"
ansible-playbook -i /tmp/ansible/localhost /vagrant/ansible/pj_setup.yml
ansible-playbook -i /tmp/ansible/localhost /vagrant/ansible/pj_env_setup.yml
ansible-playbook /vagrant/ansible/docker.yml

rm -f /tmp/ansible/localhost

USERNAME=$(grep -P '^pj_name:' /vagrant/ansible/group_vars/localhost | awk '{ print $2 }')
sudo -u ${USERNAME} ansible-playbook /vagrant/ansible/local_user.yml
