resource "tencentcloud_security_group" "sg_gz" {
    name = "sg-gz"
}

resource "tencentcloud_security_group_lite_rule" "sg_gz" {
    security_group_id = tencentcloud_security_group.sg_gz.id

    ingress = [
        "ACCEPT#192.168.1.0/24#80#TCP",
        "DROP#8.8.8.8#80,90#UDP",
        "ACCEPT#0.0.0.0/0#80-90#TCP",
    ]

    egress = [
        "ACCEPT#192.168.0.0/16#ALL#TCP",
        "ACCEPT#10.0.0.0/8#ALL#ICMP",
        "DROP#0.0.0.0/0#ALL#ALL",
    ]
}