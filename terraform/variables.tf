variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "ap-northeast-3"

}

variable "admin_ip_cidr" {
  description = "Your public IP with /32 for SSH access; empty disables SSH"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}