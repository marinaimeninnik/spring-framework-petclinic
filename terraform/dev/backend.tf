terraform {
  backend "s3" {
    bucket = "jenkinsterraform-state"
    key    = "dev/terraform.tfstate"
    region = "eu-central-1"
    access_key = "${env.AWS_ACCESS_KEY_ID}"
    secret_key = "${env.AWS_SECRET_ACCESS_KEY}"
  }
}
