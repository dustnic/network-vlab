resource "aws_security_group" "network-vlab-network-management"{
  description = "Network Management interfaces security group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  vpc_id = "${aws_vpc.network-vlab-vpc.id}"

  tags {
    Name = "network-vlab-management-security-group"
  }
}

resource "aws_security_group" "network-vlab-fabric" {
  description = "Security Group for the P2P fabric interfaces"

  vpc_id = "${aws_vpc.network-vlab-vpc.id}"

  tags {
    Name = "network-vlab-p2p-security-group"
  }
}