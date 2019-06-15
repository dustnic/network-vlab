data "aws_availability_zones" "available" {}

variable "vpc-cidr" {
  type = "string"
  default = "192.168.0.0/16"
}

variable "network-vlab-management-subnet-address" {
  type = "string"
  default = "192.168.0.0"
}

variable "network-vlab-management-subnet-length" {
  type = "string"
  default = "24"
}