provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux2" {
 most_recent = true
 owners = ["amazon"]

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm-2.0*-x86_64-gp2"]
 }

 filter {
   name   = "architecture"
   values = ["x86_64"]
 }
 
}

/*
data "template_file" "installscript" {
template = file("./install.sh")
vars = {
  env_file_url = var.environment_file_url
  }
}
*/

## EC2 Instance
resource "aws_instance" "cjitsiYse_instance" {
  ami           = data.aws_ami.amazon_linux2.id
  instance_type = var.instance_type
  key_name = var.key_pair
  security_groups = [aws_security_group.cjitsiYse_sg.name]
#  user_data = data.template_file.installscript

  tags = {
    Name = join("_", [var.base_prefix, "instance"])
    Project = var.base_prefix
  }
}


## Elastic IP Address
resource "aws_eip_association" "cjitsiYse_eip" {
  instance_id   = aws_instance.cjitsiYse_instance.id
  allocation_id = var.elastic_ip
}

## Security Group
resource "aws_security_group" "cjitsiYse_sg" {
  name = join("_", [var.base_prefix, "sg"])
  description = "Allow jitsi traffic"
  vpc_id      = var.region_defaultvpc

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_ipv4_cidr_1
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_1
  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingress_ipv4_cidr_1
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_1
  }

  ingress {
    description = "weird https"
    from_port   = 4443
    to_port     = 4443
    protocol    = "tcp"
    cidr_blocks = var.ingress_ipv4_cidr_1
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_1
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_ipv4_cidr_2
  }

  ingress {
    description = "custom udp"
    from_port   = 10000
    to_port     = 10000
    protocol    = "udp"
    cidr_blocks = var.ingress_ipv4_cidr_1
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_1
  }

  ingress {
    description = "custom udp"
    from_port   = 20000
    to_port     = 20050
    protocol    = "udp"
    cidr_blocks = var.ingress_ipv4_cidr_1
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_1
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = join("_", [var.base_prefix, "sg"])
    Project = var.base_prefix
  }
}