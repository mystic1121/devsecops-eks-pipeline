variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "turbo-task"
}

variable "admin_ip" {
  description = "Your public IP address for secure SSH, Jenkins, and SonarQube access (e.g. 203.0.113.25/32)"
  type        = string
}