# Install ansible

sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

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

sudo ansible-playbook -i ansible_hosts playbook.yml
