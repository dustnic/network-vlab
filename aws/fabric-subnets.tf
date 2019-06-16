resource "aws_subnet" "network-vlab-fabric-subnets" {
  count = "${var.fabric-links-count}"
  vpc_id = "${aws_vpc.network-vlab-vpc.id}"
  cidr_block = "${cidrsubnet(var.network-vlab-fabric-subnet-range,4,count.index)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, 0)}"
   tags {
    Name = "network-vlab-fabric-subnet-${count.index}"
  }
}