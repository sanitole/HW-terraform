#!/bin/bash

terraform -h > /dev/null
status=$?
if [ $status -eq 0 ]
then
echo “installed Terraform on $(hostname)”
else
echo “Terraform not installed $(hostname)”
LATEST_URL=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r ‘.versions[].builds[].url’ | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v ‘rc|beta’ | egrep ‘linux.*amd64’ |tail -1)
curl ${LATEST_URL} > /tmp/terraform.zip
mkdir -p ${HOME}/bin
(cd ${HOME}/bin && unzip /tmp/terraform.zip)
if [[ -z $(grep ‘export PATH=${HOME}/bin:${PATH}’ ~/.bashrc) ]]; then
echo ‘export PATH=${HOME}/bin:${PATH}’ >> ~/.bashrc
fi
echo “Installed: `${HOME}/bin/terraform version`”
cat — << EOF
Run the following to reload your PATH with terraform:
source ~/.bashrc
EOF
fi


echo "Installing ansible on Ubuntu 20.04"
echo "Updating package manager"
sudo apt update
echo "Installing source repository"
sudo apt-add-repository ppa:ansible/ansible -y
echo "Updating package index with source repository"
sudo apt update
echo "Installing ansible"
sudo apt install ansible -y
echo "Ansible version"
ansible --version