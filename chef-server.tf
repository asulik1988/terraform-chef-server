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

data "aws_ami" "centos" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "chef-server-ec2" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
}

output "chef-server.ip" {
  value = "${aws_instance.chef-server-ec2.public_ip}"
}
