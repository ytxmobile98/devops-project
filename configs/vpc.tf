resource "tencentcloud_vpc" "vpc_gz" {
  name = var.vpc_name
  cidr_block = var.vpc_cidr_block
  is_multicast = false
}