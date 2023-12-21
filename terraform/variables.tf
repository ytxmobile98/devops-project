# GitHub configurations
variable "github_username" {
  default = "ytxmobile98"
}
variable "github_personal_token" {
  default = ""
}

# Jenkins configurations
variable "jenkins_values_prefix" {
  default = "ytxmobile"
}
variable "jenkins_values_domain" {
  default = "devopscamp.us"
}

# Argo CD configurations
variable "argocd_domain" {
  default = "devopscamp.us"
}