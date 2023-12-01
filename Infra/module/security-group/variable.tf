# MODULE variable.tf

variable "name" {
  description = "Name of the security group"
  
}

variable "description" {
  description = "Description of the security group"
}

variable "vpc_id" {
  description = "ID of the VPC"
}