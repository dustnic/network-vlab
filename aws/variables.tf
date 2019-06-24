data "aws_availability_zones" "available" {}

variable "vpc-cidr" {
  type = "string"
  default = "192.168.0.0/16"
}

variable "network-vlab-management-subnet-range" {
  type = "string"
  default = "192.168.0.0/24"
}

variable "network-vlab-fabric-subnet-range" {
  type = "string"
  default = "192.168.100.0/24"
}

variable "spines" {
  type = "string"
  default = "2"
}

variable "leafs" {
  type = "string"
  default = "4"
}

variable "fabric-links-count" {
  type = "string"
  default = "8"
}

variable "spine-ami" {
  type = "string"
  default = "ami-0ba764a137b984da9"
}

variable "leaf-ami" {
  type = "string"
  default = "ami-0ba764a137b984da9"
}

variable "spine-instance-type" {
  type = "string"
  default = "c5.xlarge"
}

variable "key-name" {
  type = "string"
  default = "vlab"
}