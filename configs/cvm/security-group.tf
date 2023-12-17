resource "tencentcloud_security_group" "sg_gz" {
  name = "sg_gz"
}

resource "tencentcloud_security_group_lite_rule" "sg_gz" {
  security_group_id = tencentcloud_security_group.sg_gz.id

  ingress = [
    "ACCEPT#0.0.0.0/0#ALL#ICMP", # Allow ping
    "ACCEPT#0.0.0.0/0#22#TCP",   # Allow SSH access
    "ACCEPT#0.0.0.0/0#80#TCP",   # Allow HTTP access
    "ACCEPT#0.0.0.0/0#443#TCP",  # Allow HTTPS access
    "ACCEPT#0.0.0.0/0#6443#TCP", # For Kubernetes
    "ACCEPT#0.0.0.0/0#ALL#TCP",  # Allow all TCP access
  ]
  egress = [
    "ACCEPT#0.0.0.0/0#ALL#ALL",
  ]
}