# Install ansible
sudo apt-get update
sudo apt-get install python-pip python-dev -y
sudo pip install ansible

sudo ansible-galaxy install allomov.bosh-jumpbox

echo "127.0.0.1" > $HOME/ansible_hosts

ansible-playbook -i $HOME/ansible_hosts jumpbox.yml
