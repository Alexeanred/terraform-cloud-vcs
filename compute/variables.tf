variable "instance_type" {
  type = string
  default = "t3.small"
}

variable "public_subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}