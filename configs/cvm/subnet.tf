resource "tencentcloud_subnet" "subnet_gz" {
  name              = "subnet_gz"
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.cvm_availability_zone
  vpc_id            = tencentcloud_vpc.vpc_gz.id
}