resource "tencentcloud_security_group" "sg_gz" {
  name = var.security_group_name
}

resource "tencentcloud_security_group_lite_rule" "sg_gz" {
  security_group_id = tencentcloud_security_group.sg_gz.id

  ingress = var.security_group_ingress
  egress = var.security_group_egress
}