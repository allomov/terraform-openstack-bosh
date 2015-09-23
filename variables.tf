variable "openstack_identity_endpoint" {}
variable "openstack_username" {}
variable "openstack_password" {}
variable "openstack_tenant_name" {}
variable "openstack_key_path" {}
variable "openstack_key_name" {}
variable "openstack_public_network_id" {}

variable "openstack_region"    { default = "regionOne" }
variable "network"             { default = "10.10" }
variable "offset"              { default = "0" }
variable "default_image_name"  { default = "Ubuntu 14.04" }
variable "default_flavor_name" { default = "m1.medium" }