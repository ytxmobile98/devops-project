# CVM Region and availability zone
# See: https://www.tencentcloud.com/zh/document/product/213/6091
variable "cvm_region" {
  default = "ap-guangzhou"
}
variable "cvm_availability_zone" {
  default = "ap-guangzhou-3"
}

# CVM Image ID
# See: https://cloud.tencent.com/document/api/213/15715
variable "cvm_image_id" {
  default = "img-eb30mz89"
}

# CVM Instance type
# See: https://cloud.tencent.com/document/api/213/15749
variable "cvm_instance_type" {
  default = "S2.MEDIUM2"
}

# CVM Disk type
# See: https://cloud.tencent.com/document/product/362/16312
variable "cvm_disk_type" {
  default = "CLOUD_PREMIUM"
}