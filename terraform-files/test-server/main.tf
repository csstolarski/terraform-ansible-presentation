//here we define what cloud provider to use + connect it with out aws account
provider "aws" {
  region = var.region
  shared_credentials_file = "/Users/christopherstolarski/.aws/credentials"
}

//This is where we define the ami that we are going to use
data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20190823.1-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

//Modules are templates, they make it easy to define more than one resource at once
module "test-server-a" {
  source                 = "../modules/test-server"
  ami                    = data.aws_ami.linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.allow_ssh.name,aws_security_group.allow_ping.name,aws_security_group.allow_all_outbound.name]  
  tags = merge({
    "name" = "test-server-a"
    "purpose" = "present terraform"
  })
}

//Adding new hardware is as simple as copy and pasting the block above and then change 'test-server-a' to b
//Just make sure to change all references to the previous instance, ie a to b.
module "test-server-b" {
  source                 = "../modules/test-server"
  ami                    = data.aws_ami.linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  security_groups        = [aws_security_group.allow_ssh.name,aws_security_group.allow_ping.name,aws_security_group.allow_all_outbound.name]  
  tags = merge({
    "name" = "test-server-b"
    "purpose" = "present terraform"
  })
}

//here we define a aws_key public key to give to our servers. 
resource "aws_key_pair" "ansible-key" {
  key_name   = var.key_name
  public_key = var.public_key
}

//Adding this security group allows us to ssh into our instances. The CIDR block ensures that only someone with
//out ip is able to ssh into our machine.
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh in our ec2 instances"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22 
    protocol    = "tcp"
    cidr_blocks = ["${var.host_ip}/32"]
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  }
}

resource "aws_security_group" "allow_ping"{
  name = "allow_ping"
  description = "Allows us to ping our ec2 instances"

  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["${var.host_ip}/32"]
  }
}

resource "aws_security_group" "allow_all_outbound"{
  name = "allow_outbound"
  description = "Allow all outbound traffic"
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

