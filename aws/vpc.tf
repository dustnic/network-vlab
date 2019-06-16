# Create network-vlab vpc
resource "aws_vpc" "network-vlab-vpc" {
  cidr_block = "${var.vpc-cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "network-vlab-vpc"
  }
}
# Create internet gateway
resource "aws_internet_gateway" "network-vlab-igw" {
  vpc_id = "${aws_vpc.network-vlab-vpc.id}"

  tags {
    Name = "network-vlab-vpc-igw"
  }
}

# Create management subnet
resource "aws_subnet" "network-vlab-management-subnets" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.network-vlab-vpc.id}"
  cidr_block = "${cidrsubnet(var.network-vlab-management-subnet-range,2,count.index)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index%length(data.aws_availability_zones.available.names))}"

  tags {
    Name = "network-vlab-management-subnet-${element(data.aws_availability_zones.available.names, count.index%length(data.aws_availability_zones.available.names))}"
  }
}

#Add default routes to management subnet RTR
resource "aws_route_table" "network-vlab-management-rt" {
  vpc_id = "${aws_vpc.network-vlab-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.network-vlab-igw.id}"
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = "${aws_internet_gateway.network-vlab-igw.id}"
  }

  tags {
    Name = "network-vlab-route-table"
  }
}

#Associate RTR to management subnet
resource "aws_route_table_association" "network-vlab-management-rt-association" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id = "${element(aws_subnet.network-vlab-management-subnets.*.id,count.index)}"
  route_table_id = "${aws_route_table.network-vlab-management-rt.id}"
}
