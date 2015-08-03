#!/usr/bin/env bash

sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y

cd `dirname $0`
if [ ! -f playbook.yml ]; then
    cd /var/www/app/provision/
fi

PYTHONUNBUFFERED=1 ansible-playbook playbook.yml --connection=local -i localhost,