module "common" {
  source = "./common"
}

module "cvm" {
  source = "./cvm"
}

module "k3s" {
  source     = "./k3s"
  depends_on = [module.cvm]

  public_ip    = module.cvm.cvm_instances[0].public_ip
  private_ip   = module.cvm.cvm_instances[0].private_ip
  server_name  = module.common.k3s.server_names[0]
  ssh_user     = module.common.cvm.connection.user
  ssh_password = module.common.cvm.connection.password
}