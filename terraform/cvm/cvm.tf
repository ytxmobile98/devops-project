resource "tencentcloud_instance" "devops_cvm_1" {
  instance_name     = "devops_cvm_1"
  availability_zone = var.cvm_availability_zone
  image_id          = var.cvm_image_id
  instance_type     = var.cvm_instance_type

  system_disk_type = var.cvm_disk_type
  system_disk_size = 100

  vpc_id    = tencentcloud_vpc.vpc_hongkong.id
  subnet_id = tencentcloud_subnet.subnet_hongkong.id

  orderly_security_groups = [
    tencentcloud_security_group.sg_hongkong.id
  ]

  allocate_public_ip         = true
  internet_max_bandwidth_out = 100

  key_ids = [
    tencentcloud_key_pair.devops_cvm_key_pair.id
  ]
}