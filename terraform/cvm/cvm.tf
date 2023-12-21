module "common" {
  source = "../common"
}

resource "tencentcloud_instance" "cvm_1" {
  instance_name     = module.common.cvm.instance_names[0]
  availability_zone = module.common.cvm.availability_zone
  image_id          = module.common.cvm.image_id
  instance_type     = module.common.cvm.instance_type

  system_disk_type = module.common.cvm.disk_type
  system_disk_size = 100

  vpc_id    = tencentcloud_vpc.vpc_hongkong.id
  subnet_id = tencentcloud_subnet.subnet_hongkong.id

  orderly_security_groups = [
    tencentcloud_security_group.sg_hongkong.id
  ]

  allocate_public_ip         = true
  internet_max_bandwidth_out = 100

  password = module.common.cvm.connection.password
}