terraform {
  backend "s3" {
    bucket = "arn:aws:s3:::jenkinsterraform-state"
    key    = "dev/terraform.tfstate"
    region = "eu-central-1"
  }
}
