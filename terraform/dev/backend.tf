terraform {
  backend "s3" {
    bucket = "jenkinsterraform-state"
    key    = "dev/terraform.tfstate"
    region = "eu-central-1"
  }
}