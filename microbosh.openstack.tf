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

resource "openstack_compute_floatingip_v2" "jumpbox" {
  pool = "net04_ext"
}

resource "openstack_compute_instance_v2" "jumpbox" {

  name = "jumpbox"

  flavor_name = "m1.small"

  network = {
    uuid = "${openstack_networking_network_v2.network_1.id}"
  }

  availability_zone = "${var.openstack_availability_zone}"

  floating_ip = "${openstack_compute_floatingip_v2.jumpbox.address}"

  security_groups = [
      "${openstack_compute_secgroup_v2.ssh.name}",
      "${openstack_compute_secgroup_v2.bosh.name}"
    ]

  key_pair = "${var.jumpbox_key_pair}"

  block_device {
    uuid = "${var.jumpbox_image_id}"
    source_type = "image"
    volume_size = 100
    boot_index = 0
    destination_type = "volume"
  }

  provisioner "remote-exec" {
    connection {
      user = "ubuntu"
      type = "ssh"
      key_file = "${file("${var.jumpbox_private_key}")}"
      timeout = "2m"
    }
    script = "scripts/jumpbox.sh"
  }

}
