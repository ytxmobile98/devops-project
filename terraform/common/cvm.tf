output "cvm" {
  value = {
    # Region and availability zone
    # See: https://www.tencentcloud.com/zh/document/product/213/6091
    region            = "ap-hongkong"
    availability_zone = "ap-hongkong-2"

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