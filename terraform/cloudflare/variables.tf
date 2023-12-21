# API token
variable "api_token" {
  type    = string
  default = ""
}

# Domain names
variable "domain" {
  type    = string
  default = ""
}
variable "prefix" {
  type    = string
  default = ""

}
variable "sub_names" {
  type    = list(string)
  default = []
}

# IP
variable "ip" {
  type    = string
  default = ""
}