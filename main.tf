provider "aws" {
  region = data.terraform_remote_state.admnet.outputs.region_name

  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
}

provider "vault" {}

data "terraform_remote_state" "admin" {
  backend = "remote"

config = {
    organization = "testsam1"
    workspaces   = {
      name = "hashicorp-vault-admin"
    }
  }
}

data "vault_aws_access_credentials" "creds" {
  backend = data.terraform_remote_state.admin.outputs.backend
  role    = data.terraform_remote_state.admin.outputs.rolenet
}




data "terraform_remote_state" "admnet" {
  backend = "remote"

config = {
    organization = "testsam1"
    workspaces   = {
      name = "aws-terraform-network"
    }
  }
}

resource "aws_security_group" "ec2" {
   name       = "${var.sg_name}-sg"
   description = "the security group"
   vpc_id      = "${data.terraform_remote_state.admnet.outputs.vpc_id}"


   ingress {
     from_port  = var.ports[0]
     to_port    = var.ports[0]
     protocol   = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
     from_port  = var.ports[1]
     to_port    = var.ports[1]
     protocol   = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
     from_port  = var.ports[2]
     to_port    = var.ports[2]
     protocol   = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
     from_port  = var.ports[3]
     to_port    = var.ports[3]
     protocol   = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
     from_port  = var.ports[4]
     to_port    = var.ports[4]
     protocol   = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   egress {
     from_port  = 0
     to_port    = 0
     protocol   = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
 }
