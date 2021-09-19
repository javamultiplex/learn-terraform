variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "environment_name" {
  description = "Value of the Environment tag for the EC2 instance"
  type        = string
  default     = "dev"
}