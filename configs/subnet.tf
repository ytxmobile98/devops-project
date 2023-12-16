resource "tencentcloud_subnet" "subnet_gz" {
    name = "subnet_gz"
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-guangzhou-3"
    vpc_id = tencentcloud_vpc.vpc_gz.id
}