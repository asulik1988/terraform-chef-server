variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "consul-ec2" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}