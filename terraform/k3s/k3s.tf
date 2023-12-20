module "k3s" {
  source      = "xunleii/k3s/module"
  k3s_version = "v1.25.11+k3s1"

  generate_ca_certificates = true
  global_flags = [
    "--tls-san ${var.public_ip}",
    "--write-kubeconfig-mode 644",
    "--disable=traefik",
    "--kube-controller-manager-arg bind-address=0.0.0.0",
    "--kube-proxy-arg metrics-bind-address=0.0.0.0",
    "--kube-scheduler-arg bind-address=0.0.0.0"
  ]
  k3s_install_env_vars = {}

  servers = {
    "${var.server_name}" = {
      ip = var.private_ip
      connection = {
        type     = "ssh"
        timeout  = "60s"
        host     = var.public_ip
        user     = var.ssh_user
        password = var.ssh_password
      }
    }
  }
}