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

# CVM public IP & max bandwidth out
variable "cvm_allocate_public_ip" {
  default = true
}
variable "cvm_internet_max_bandwidth_out" {
  default = 100
}

# Security Group
variable "security_group_name" {
  default = "sg-gz"
}
variable "security_group_ingress" {
  type = list(string)
  default = [
    "ACCEPT#0.0.0.0/0#22#TCP", # Allow SSH access
    "ACCEPT#0.0.0.0/0#6443#TCP", # For Kubernetes
  ]
}
variable "security_group_egress" {
  type = list(string)
  default = [
    "ACCEPT#0.0.0.0/0#ALL#ALL",
  ]
}

# Subnet
variable "subnet_name" {
  default = "subnet_gz"
}
variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
}

# VPC
variable "vpc_name" {
  default = "vpc_gz"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}