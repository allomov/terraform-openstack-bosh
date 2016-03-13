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

resource "openstack_compute_instance_v2" "jumpbox" {
    name = "jumpbox"
    image_id = "${jumpbox_image_id}"
    key_pair = "${jumpbox_key_pair}"
    flavor_name = "m1.small"

    provisioner "remote-exec" {
      script = "scripts/jumpbox.sh"
    }
}
