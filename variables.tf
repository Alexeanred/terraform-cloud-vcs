variable "instance_type" {
  type        = string
  description = "The instance type of ec2 instance"
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t2.micro", "t3.small"], var.instance_type)
    error_message = "Accept instance types: t3.micro, t2.micro and t3.small"
  }
}