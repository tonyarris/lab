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
  associate_public_ip_address = true
  key_name         = "ssh-key"

  tags = {
    Name = "PT Lab Instance"
  }

root_block_device {
  volume_type = "gp2"
  volume_size = 30
}

  user_data = <<-EOF
    #!/bin/bash
    # clone lab repo and setup filesystem
    sudo su
    git clone https://github.com/tonyarris/lab /home/ubuntu/lab
    cd /home/ubuntu/lab
    cp stop.sh kali
    cp stop.sh parrot
    rm stop.sh
    rm -r terraform/

    # install docker
    apt-get -y update
    apt-get -y upgrade
    apt-get -y install docker.io

    # build containers
    cd kali
    chmod +x *.sh
    ./build.sh
    cd ../parrot
    chmod +x *.sh
    ./build.sh
    
  EOF
}

output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.pt_lab.public_ip
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl9VKriojo6Q60esciAHQxKh8g6Tb00eYIHdAm8RuqPry5xTFP+gh0GS4ub0hZBnOyvC6sa4B/1MTNjL+Ex4rkUfM0gHH0PSSImJPBzKtQQ+sCxk4TsKTjfqxUHQQeaQgqufpy9uiXLRKdX0mZJLWv/Q2o6Dbcj7XhZqdrSzLKHqm7cCjv5b7AzVCRXlENA7fFSDXuupaNyWwfubn55qVielLQOJOTnNuuS2RQrNKDVWSMqAVds+E0SeFVikRAqhbd0YNWYqs139Z/bu9R9vMhLs1HElRimCwx1itjn+GHCLQ25chJHu1+snJmWakjxuLQz0Y8qoo+xrFluzQXQWo1"
}