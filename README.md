### How to install

I use the latest version of terraform. You can use `./build` script to fetch and build terraform localy in this project.
Before running `./build` you need to have `golang`, `mercurial` and `git` installed. `./build` script relies on environment variables that are stored in `.envrc` file, you can use [direnv](http://direnv.net/).

### How to use
First you need to redefine variables in `terraform.tfvars` file, to do it you'll probably want to use `terraform.tfvars.example` as an example. After this is ready you can simply run:
```
make plan
make apply
```

Enjoy!

### Notes

You can use `python-novaclient` to find out external network ID (`openstack_public_network_id` attribute). In order to do it run following commands:
```
pip install python-novaclient  # possibly you'll need to run it under sudo
nova --os-username=xxx --os-password=xxx --os-tenant-name=xxx --os-auth-url="xxx" --os-compute-api-version=2 network-list
```
