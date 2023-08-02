#
# Variables Configuration
#

variable "cluster-name" {
  default = "terraform-eks-sampleprivatecluster"
  type    = string
}

variable "ami_key_pair_name" {
  type = string
  default = "jkey"
}

variable "AWS_REGION" {
  default = "us-east-1"
}

# Amazon Linux AMI-Ids 
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1       = "ami-0ab4d1e9cf9a1215a"
	ap-southeast-2  = "ami-0c9fe0dec6325a30c"
	ap-southeast-1  = "ami-0e5182fad1edfaa68"
	us-east-2       = "ami-0233c2d874b811deb"
	ap-south-1      = "ami-00bf4ae5a7909786c"
  }
}
