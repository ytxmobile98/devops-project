resource "tencentcloud_vpc" "vpc_gz" {
  name         = "vpc_gz"
  cidr_block   = "10.0.0.0/16"
  is_multicast = false
}