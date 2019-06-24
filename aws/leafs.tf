resource "aws_instance" "network-vlab-leaf-0" {
  ami = "${var.leaf-ami}"
  instance_type = "${var.spine-instance-type}"
  key_name = "${var.key-name}"
  subnet_id = "${aws_subnet.network-vlab-management-subnets.0.id}"
  vpc_security_group_ids = ["${aws_security_group.network-vlab-network-management.id}"]
 
  associate_public_ip_address = true
  source_dest_check = false
  tags = {
    Name = "network-vlab-leaf-0"
  }
}

resource "aws_network_interface" "leaf-0-spine-0" {
  subnet_id       = "${aws_subnet.network-vlab-fabric-subnets.0.id}"
  security_groups = ["${aws_security_group.network-vlab-fabric.id}"]

  attachment {
    instance     = "${aws_instance.network-vlab-leaf-0.id}"
    device_index = 1
  }
}

resource "aws_network_interface" "leaf-0-spine-1" {
  subnet_id       = "${aws_subnet.network-vlab-fabric-subnets.4.id}"
  security_groups = ["${aws_security_group.network-vlab-fabric.id}"]

  attachment {
    instance     = "${aws_instance.network-vlab-leaf-0.id}"
    device_index = 2
  }
}