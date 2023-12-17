resource "tencentcloud_instance" "devops_cvm_1" {
  instance_name = "devops_cvm_1"
  availability_zone = var.cvm_availability_zone
  image_id = var.cvm_image_id
  instance_type = var.cvm_instance_type
  system_disk_type = var.cvm_disk_type

  orderly_security_groups = [
    tencentcloud_security_group.sg_gz.id
  ]
  vpc_id = tencentcloud_vpc.vpc_gz.id
  subnet_id = tencentcloud_subnet.subnet_gz.id

  allocate_public_ip = var.cvm_allocate_public_ip
  internet_max_bandwidth_out = var.cvm_internet_max_bandwidth_out
}