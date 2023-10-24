variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "ami" {
   type        = string
   description = "Ubuntu AMI ID"
   default     = "ami-06dd92ecc74fdfb36"
}

variable "instance_type" {
   type        = string
   description = "Instance type"
   default     = "t2.micro"
}

variable "name_tag" {
   type        = string
   description = "Name of the EC2 instance"
   default     = "DEV EC2 Instance"
}

variable "docker_image" {
  type        = string
  description = "Docker image to deploy"
  default     = "marinaimeninnik/spring-framework-petclinic:1.0.61"
}

variable "ssh_key_name" {
  type        = string
  description = "Name of the SSH key credential in Jenkins"
  default     = "ubuntu (terraform-remote-exec)"
}