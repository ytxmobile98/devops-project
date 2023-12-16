resource "tencentcloud_instance" "devops_cvm" {
  instance_name = "devops_cvm"
  availability_zone = var.availability_zone
  image_id = "img-eb30mz89" # May be obtained using https://console.cloud.tencent.com/api/explorer?Product=cvm&Version=2017-03-12&Action=DescribeImages
  instance_type = "S2.MEDIUM2"
  system_disk_type = "CLOUD_PREMIUM"

  orderly_security_groups = [
    tencentcloud_security_group.sg_gz.id
  ]
  vpc_id = tencentcloud_vpc.vpc_gz.id
  subnet_id = tencentcloud_subnet.subnet_gz.id

  count = 3
}