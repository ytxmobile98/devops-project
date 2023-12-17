module "k3s" {
  source = "xunleii/k3s/module"

  servers = {
    k3s_server_1 = {
      ip = tencentcloud_instance.devops_cvm_1.private_ip
      connection = {
        timeout = "60s"
        type = "ssh"
        host = tencentcloud_instance.devops_cvm_1.public_ip
      }
    }
  }
}