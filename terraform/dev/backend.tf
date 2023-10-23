terraform {
  backend "s3" {
    bucket = "arn:aws:s3:eu-central-1:519240998635:accesspoint/acc1"
    key    = "dev/terraform.tfstate"
    region = "eu-central-1"
  }
}
