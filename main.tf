provider "aws" {
  region                  = "ap-southeast-2"
  profile                 = "default"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_vpc" "vault-vpc" {
  cidr_block = "10.1.2.0/16"
  tags = {
      project = var.project-tag
  }
}

resource "aws_subnet" "vault-subnet" {
  vpc_id = "${aws_vpc.vault-vpc.id}"
  cidr_block = "10.1.2.0/24"
  tags = {
      project = var.project-tag
  }
}


resource "aws_instance" "vault" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  vpc_security_group_ids = [aws_security_group.vault.id]

  tags = {
      project = var.project-tag
  }
}

resource "aws_security_group" "vault" {
  name= "vault-security-group"

}

resource "aws_security_group_rule" "vault_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.vault.id
  from_port = var.vault_port
  to_port = var.vault_port
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

}
