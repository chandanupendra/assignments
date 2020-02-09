#Terraform template to provision ec2 instance with security group.

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Variable : Default Values If user parameters not available.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

variable "region" {
    type = "string"
    description = "AWS Region to create resource"
    default = "ap-south-1"
}
variable "ami" {
    type = "string"
    description = "AWS AMI Id for the ec2 instance"
    default = "ami-0d11056c10bfdde69"
}
variable "instance_type" {
    type = "string"
    description = "AWS Instance Type to create"
    default = "t3a.small"
}
variable "ec2_name" {
    type = "string"
    description = "AWS Instance Name"
    default = "terraform-test-instance"
}
variable "ec2_az" {
    type = "string"
    description = "AWS Availability Zone"
    default = "ap-south-1a"
}
variable "sg_name" {
    type = "string"
    description = "Security Group Name"
    default = "terraform-test-instance-sg"
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Creating EC2 Resource : Instance, Security Group !
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

provider "aws" {
  region     = "${var.region}"
  access_key = "AAAAAAAAAAAAAAAA"
  secret_key = "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
}
resource "aws_security_group" "terraform-test-instance-sg" {
  name = "${var.sg_name}"
  description = "Its Test Security Group"
}
resource "aws_security_group_rule" "ssh_ingress_access" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = "${aws_security_group.terraform-test-instance-sg.id}"
}
resource "aws_security_group_rule" "terraform-test-egress_access" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = "${aws_security_group.terraform-test-instance-sg.id}"
}
resource "aws_instance" "terraform-test-instance" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = true
  vpc_security_group_ids = [ "${aws_security_group.terraform-test-instance-sg.id}" ]
    tags {
    Name = "${var.ec2_name}"
    availability_zone = "${var.ec2_az}"
  }
}

