terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "askarpoff-bucket"
    region                      = "ru-central1-b"
    key                         = "terraform_ex2/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}