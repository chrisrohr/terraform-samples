terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.15"
        }

        consul = {
            source  = "hashicorp/consul"
            version = "~> 2.15"
        }

        vault = {
            source  = "hashicorp/vault"
            version = "~> 3.6"
        }

        http = {
            source  = "hashicorp/http"
            version = "~> 2.1"
        }

        tls = {
            source  = "hashicorp/tls"
            version = "~> 3.4"
        }

        dns = {
            source  = "hashicorp/dns"
            version = "~> 3.2"
        }

        local = {
            source  = "hashicorp/local"
            version = "~> 2.2"
        }
    }
}

provider "aws" {
    profile = "default"
    region  = "us-east-1"
}

data "aws_ami" "web_linux" {
    most_recent = true

    filter {
        name    = "name"
        values  = ["Amazon Linux 2 AMI (HVM) - Kernel 5.10*"]
    }

    filter {
        name    = "virtualization-type"
        values  = ["hvm"]
    }

    owners = ["abc"]
}

resource "aws_instance" "web" {
    ami             = data.aws_ami.web_linux.id
    instance_type   = "t3.medium"
    count           = 2

    tags = {
        Name = "BC Web ${count.index}"
    }
}
