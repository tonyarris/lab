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
  ami           = "ami-0f8ce9c417115413d"
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
    git clone https://github.com/tonyarris/lab /home/$(whoami)/lab
    cd /home/$(whoami)/lab
    cp stop.sh kali
    cp stop.sh parrot
    rm stop.sh
    rm -r terraform/

    # install docker
    sudo apt-get -y update
    sudo apt-get -y upgrade
    sudo apt-get -y install docker.io

    # build containers
    cd kali
    sudo chmod +x *.sh
    sudo ./build.sh
    cd ../parrot
    sudo chmod +x *.sh
    sudo ./build.sh
    
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