resource "tencentcloud_vpc" "vpc_hongkong" {
  name         = "vpc_hongkong"
  cidr_block   = "10.0.0.0/16"
  is_multicast = false
}