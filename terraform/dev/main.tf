terraform{
    required_providers {
        aws = {
            source  = "registry.terraform.io/hashicorp/aws"
            version = "~> 4.48.0"
            
        }
    }
}

variable "access_key" {
  description = "AWS access key"
}

variable "secret_key" {
  description = "AWS secret key"
}

# Variables specific to the dev environment
variable "instance_count" {
  type    = number
  default = 1
}

# Example AWS provider configuration
provider "aws" {
  region = "eu-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Resource configuration for EC2 instances in the dev environment
resource "aws_instance" "Ubuntu-dev" {
  count         = var.instance_count
  ami           = "ami-06dd92ecc74fdfb36"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.dev-security_group.id}"]
}

resource "aws_security_group" "dev-security_group" {
  name        = "dev-security_group"
  description = "Used in the terraform"
  # vpc_id      = "${aws_vpc.default.id}"
  lifecycle {
    create_before_destroy = true
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound internet access
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the internet
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}