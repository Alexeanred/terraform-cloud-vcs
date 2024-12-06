variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "public_subnet_id" {
  type = string
}

variable "sg_id" {
  type = string
}