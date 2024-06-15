terraform {
  required_providers {
    ncloud = {
        source = "NaverCloudPlatform/ncloud"
    }
  }
  required_version = ">= 0.13"
}

provider "ncloud" {
  support_vpc = true
  region = "KR"
}

resource "ncloud_login_key" "teentalktalk_login_key" {
  key_name = "teentalktalkkey"
}

output "teentalktalk_login_key" {
  value = ncloud_login_key.teentalktalk_login_key.private_key
  sensitive = true
}

resource "ncloud_vpc" "teentalktalk_vpc" {
  name = "teentalktalk-vpc"
  ipv4_cidr_block = "10.0.0.0/16"
}

resource "ncloud_subnet" "teentalktalk_subnet_private_db" {
  vpc_no = ncloud_vpc.teentalktalk_vpc.id
  zone = "KR-1"
  subnet = "10.0.1.0/24"
  network_acl_no = ncloud_vpc.teentalktalk_vpc.default_network_acl_no
  subnet_type = "PRIVATE"
  usage_type = "GEN"
}

resource "ncloud_subnet" "teentalktalk_subnet_public_backend" {
  vpc_no = ncloud_vpc.teentalktalk_vpc.id
  zone = "KR-1"
  subnet = "10.0.2.0/24"
  network_acl_no = ncloud_vpc.teentalktalk_vpc.default_network_acl_no
  subnet_type = "PUBLIC"
  usage_type = "GEN"
}

resource "ncloud_server" "teentalktalk_server_db" {
  name = "teentalktalk-server-db"
  subnet_no = ncloud_subnet.teentalktalk_subnet_private_db.id
  server_image_product_code = "SW.VSVR.OS.LNX64.ROCKY.0808.B050"
  login_key_name = ncloud_login_key.teentalktalk_login_key.key_name
}

resource "ncloud_server" "teentalktalk_server_backend" {
  name = "teentalktalk-server-backend"
  subnet_no = ncloud_subnet.teentalktalk_subnet_public_backend.id
  server_image_product_code = "SW.VSVR.OS.LNX64.ROCKY.0808.B050"
  login_key_name = ncloud_login_key.teentalktalk_login_key.key_name
}
