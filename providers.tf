#
# Provider Configuration
#
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
  region  = "${var.AWS_REGION}"
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

#provider "http" {
#  version = "~> 1.0"
#}

#variable "ami_name" {}
#variable "ami_id" {}
#variable "ami_key_pair_name" {}
