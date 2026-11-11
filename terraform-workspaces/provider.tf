terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }

    backend "s3" {
    bucket = "roboshop-tf-state-bucket"
    key = "workspaces.tfstate"
    encrypt = true
    region = "us-east-1"
    
}


}

provider "aws" {

    region = "us-east-1"
  
}