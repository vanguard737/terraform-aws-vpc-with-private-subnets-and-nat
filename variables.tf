variable "project" {
}

variable "nat_mode" {
  // TODO allow to disable creation of any type nat
  description = "Valid values: 'instance' or 'gateway'.  Read more: https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-nat-comparison.html"
  default     = "instance"
}

locals {
  nat_instance  = var.nat_mode == "gateway" ? false : true
  nat_gw        = var.nat_mode == "gateway" ? true : false
}

variable "nat_instance_type" {
  default = "t2.micro"
}
