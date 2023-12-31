locals {
  init_script_source          = "${path.module}/../scripts/init.sh"
  init_script_destination_dir = "/tmp/scripts"
  init_script_destination     = "${local.init_script_destination_dir}/${basename(local.init_script_source)}"

  yaml_dir_source      = "${path.module}/../yaml"
  yaml_dir_destination = "/tmp/yaml"
  yaml_dirnames = [
    "argocd",
    "crossplane",
    "github",
    "jenkins",
    "nginx",
  ]

  domain = module.common.domain
  prefix = module.common.prefix
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

module "cloudflare" {
  source = "./cloudflare"

  api_token = var.cloudflare_api_token
  domain    = local.domain
  prefix    = local.prefix
  ip        = module.cvm.cvm_instances[0].public_ip
  sub_names = ["argocd", "jenkins"]
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

  # Create directories needed for initialization
  provisioner "remote-exec" {
    inline = concat(
      [
        # Create init script directory
        "mkdir -p ${local.init_script_destination_dir}",
      ],
      [
        # Create YAML directories
        for dir in local.yaml_dirnames : "mkdir -p ${local.yaml_dir_destination}/${dir}"
      ],
    )
  }

  # GitHub configuration files
  provisioner "file" {
    destination = "${local.yaml_dir_destination}/github/pat-secret-text.yaml"
    content = templatefile(
      "${local.yaml_dir_source}/github/pat-secret-text.yaml.tpl",
      {
        github_personal_token = var.github_personal_token,
      }
    )
  }
  provisioner "file" {
    destination = "${local.yaml_dir_destination}/github/personal-token.yaml"
    content = templatefile(
      "${local.yaml_dir_source}/github/personal-token.yaml.tpl",
      {
        github_username       = var.github_username,
        github_personal_token = var.github_personal_token,
      }
    )
  }

  # Jenkins configuration files
  provisioner "file" {
    destination = "${local.yaml_dir_destination}/jenkins/service-account.yaml"
    source      = "${local.yaml_dir_source}/jenkins/service-account.yaml"
  }
  provisioner "file" {
    destination = "${local.yaml_dir_destination}/jenkins/values.yaml"
    content = templatefile(
      "${local.yaml_dir_source}/jenkins/values.yaml.tpl",
      {
        prefix = local.prefix,
        domain = local.domain,
      }
    )
  }

  # NGINX configuration files
  provisioner "file" {
    destination = "${local.yaml_dir_destination}/nginx/ingress-value.yaml"
    source      = "${local.yaml_dir_source}/nginx/ingress-value.yaml"
  }

  # Crossplane configuration files
  provisioner "file" {
    destination = "${local.yaml_dir_destination}/crossplane/provider.yaml"
    source      = "${local.yaml_dir_source}/crossplane/provider.yaml"
  }

  # Argo CD configuration files
  provisioner "file" {
    destination = "${local.yaml_dir_destination}/argocd/applicationset.yaml"
    source      = "${local.yaml_dir_source}/argocd/applicationset.yaml"
  }
  provisioner "file" {
    destination = "${local.yaml_dir_destination}/argocd/dashboard-ingress.yaml"
    content = templatefile(
      "${local.yaml_dir_source}/argocd/dashboard-ingress.yaml.tpl",
      {
        domain = local.domain,
      }
    )
  }

  # init script
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