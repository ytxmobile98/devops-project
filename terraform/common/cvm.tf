output "cvm" {
  value = {
    # Region and availability zone
    # See: https://www.tencentcloud.com/zh/document/product/213/6091
    region            = "ap-hongkong"
    availability_zone = "ap-hongkong-2"

    # Image ID
    # See: https://cloud.tencent.com/document/api/213/15715
    image_id = "img-487zeit5" # Ubuntu Server 22.04 LTS 64-bit

    # Instance type
    # See: https://cloud.tencent.com/document/api/213/15749
    instance_type = "S2.MEDIUM2"

    # Disk type
    # See: https://cloud.tencent.com/document/product/362/16312
    disk_type = "CLOUD_PREMIUM"

    # Instance names
    instance_names = [
      "devops-hongkong-cvm-1",
      "devops-hongkong-cvm-2",
      "devops-hongkong-cvm-3",
    ]

    # Connection
    connection = {
      user     = "ubuntu"
      password = "devops123"
    }
  }
}