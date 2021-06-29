variable "vpcid" {
  #   default = "VPC_ID"
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

variable "MIN_SIZE" {}
variable "MAX_SIZE" {}
variable "DESIRED_CAPACITY" {}
variable "AUTOSCALING_NAME" {}
variable "DOWN_SCALING_ADJUSTMENT" {
  default = -1
}
variable "COOLDOWN_TIME" {
  default = 300
}
variable "UP_SCALING_ADJUSTMENT" {
  default = 1
}

variable "ADJUSTMENT_TYPE" {

}
variable "LOW_CPU_THRESHOLD" {
  default = 40
}

variable "HIGH_CPU_THRESHOLD" {
  default = 80
}

variable "SUBNETS" {
  type        = list(string)
  description = "List of subnet to create instance on."
}
