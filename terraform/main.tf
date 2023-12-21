locals {
  init_script_source      = "${path.module}/../scripts/init.sh"
  init_script_destination = "/tmp/${basename(local.init_script_source)}"
}

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

resource "null_resource" "connect_cvm_1" {
  connection {
    host     = module.cvm.cvm_instances[0].public_ip
    type     = "ssh"
    timeout  = "60s"
    user     = module.common.cvm.connection.user
    password = module.common.cvm.connection.password
  }

  triggers = {
    script_hash = join(",", [
      filemd5(local.init_script_source),
      filemd5(join("/", [path.module, "main.tf"])),
    ])
  }

  provisioner "file" {
    destination = local.init_script_destination
    source      = local.init_script_source
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.init_script_destination}",
      "sudo ${local.init_script_destination}",
    ]
  }
}