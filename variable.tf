variable "AWS_ACCESS_KEY" {

}
variable "AWS_SECRET_KEY" {

}
variable "AWS_REGION" {
}

variable "MIN_SIZE" {}
variable "MAX_SIZE" {}
variable "DESIRED_CAPACITY" {}
variable "AUTOSCALING_NAME" {}

variable "vpcid" {
  #   default = "vpc-bb2aacd0"
  type        = string
  description = "VPC ID of vpc in which resources to be created."
}

variable "IMAGE_ID" {
  type        = string
  description = "Name of image id."
}

variable "INSTANCE_TYPE" {
  type        = string
  description = "Instance Type"
}

variable "SUBNETS" {
  type        = list(string)
  description = "List of subnets."
}
