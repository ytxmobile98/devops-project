resource "tencentcloud_subnet" "subnet_hongkong" {
  name              = "subnet-hongkong"
  cidr_block        = "10.0.1.0/24"
  availability_zone = module.common.cvm.availability_zone
  vpc_id            = tencentcloud_vpc.vpc_hongkong.id
}