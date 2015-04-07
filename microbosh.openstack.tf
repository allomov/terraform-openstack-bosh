provider "openstack" {
  auth_url = "${var.openstack_identity_endpoint}"
  tenant_name = "${var.openstack_tenant_name}"
  user_name = "${var.openstack_username}"
  password = "${var.openstack_password}"
}

resource "openstack_networking_network_v2" "network_1" {
    name = "network_1"
    admin_state_up = "true"
    region = "${var.openstack_region}"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
    network_id = "${openstack_networking_network_v2.network_1.id}"
    cidr = "${var.network}.0.0/16"
    ip_version = 4
    region = "${var.openstack_region}"
}

resource "openstack_networking_router_v2" "router_1" {
  name = "router_1"
  admin_state_up = "true"
  region = "${var.openstack_region}"
  external_gateway = "${var.openstack_public_network_id}"
}

resource "openstack_networking_router_interface_v2" "int_1" {
    subnet_id = "${openstack_networking_subnet_v2.subnet_1.id}"
    router_id = "${openstack_networking_router_v2.router_1.id}"
    region = "${var.openstack_region}"

}






# Possible resources:
#   openstack_blockstorage_volume_v1
#   openstack_compute_instance_v2
#   openstack_compute_keypair_v2
#   openstack_compute_secgroup_v2
#   openstack_compute_floatingip_v2
#   openstack_fw_firewall_v1
#   openstack_fw_policy_v1
#   openstack_fw_rule_v1
#   openstack_lb_monitor_v1
#   openstack_lb_pool_v1
#   openstack_lb_vip_v1
#   openstack_networking_network_v2
#   openstack_networking_subnet_v2
#   openstack_networking_floatingip_v2
#   openstack_networking_router_v2
#   openstack_networking_router_interface_v2
#   openstack_objectstorage_container_v1


# What do I need:
#   openstack_networking_network_v2
#   openstack_networking_subnet_v2
#   openstack_compute_secgroup_v2
#   openstack_networking_router_v2
