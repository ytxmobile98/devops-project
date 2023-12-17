resource "tencentcloud_subnet" "subnet_gz" {
  name = var.subnet_name
  cidr_block = var.subnet_cidr_block
  availability_zone = var.cvm_availability_zone
  vpc_id = tencentcloud_vpc.vpc_gz.id
}