terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-south-1"
}

resource "aws_instance" "pt_lab" {
  ami           = "ami-0257e70b7c6db1498"
  instance_type = "t3.micro"

  tags = {
    Name = "PT Lab Instance"
  }
}
