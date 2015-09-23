GO_VERSON=1.4.2
RUBY_VERSION=2.1.5

sudo apt-get install -y wget tmux git mercurial

wget https://storage.googleapis.com/golang/go$GO_VERSON.src.tar.gz
tar -xvf go$GO_VERSON.src.tar.gz

# source ~/.bashrc
# gem install bosh_cli
