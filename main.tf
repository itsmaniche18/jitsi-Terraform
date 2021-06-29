module "jvb" {
  source           = "./instances"
  vpcid            = var.vpcid
  IMAGE_ID         = var.IMAGE_ID
  INSTANCE_TYPE    = var.INSTANCE_TYPE
  SUBNETS          = var.SUBNETS
  DESIRED_CAPACITY = var.DESIRED_CAPACITY
  MIN_SIZE         = var.MIN_SIZE
  MAX_SIZE         = var.MAX_SIZE
  AUTOSCALING_NAME = var.AUTOSCALING_NAME
  ADJUSTMENT_TYPE  = "ChangeInCapacity"
}
