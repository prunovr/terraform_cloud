terraform {
  cloud {
    organization = "prunov"
    workspaces {
      name = "terraform_cloud"
    }
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}