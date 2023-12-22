module "common" {
  source = "../common"
}

data "tencentcloud_availability_zones_by_product" "default" {
  product = "cvm"
}

data "tencentcloud_images" "default" {
  image_type = ["PUBLIC_IMAGE"]
  os_name = "ubuntu"
}

data "tencentcloud_instance_types" "default" {
  filter {
    name   = "instance-family"
    values = ["S5"]
  }

  filter {
    name   = "zone"
    values = [module.common.cvm.availability_zone]
  }

  cpu_core_count = 4
  memory_size    = 16
}

resource "tencentcloud_instance" "cvm_1" {
  instance_name     = module.common.cvm.instance_names[0]
  availability_zone = module.common.cvm.availability_zone
  image_id          = data.tencentcloud_images.default.images[0].image_id
  instance_type     = data.tencentcloud_instance_types.default.instance_types[0].instance_type

  system_disk_type = "CLOUD_SSD"
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