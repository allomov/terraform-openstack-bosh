# Install ansible
sudo apt-get update
sudo apt-get install python-pip python-dev -y
sudo pip install ansible

sudo ansible-galaxy install allomov.bosh-jumpbox

cat <<EOF > playbook.yml
---
- hosts: jumpbox
  roles:
  - role: allomov.bosh-jumpbox
EOF

cat <<EOF > ansible_hosts
[jumpbox]
localhost ansible_connection=local
EOF

ansible-playbook -i ansible_hosts playbook.yml
