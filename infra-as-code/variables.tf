variable "vpc_id" {
  description = "ID da VPC onde o Security Group sera criado"
  type        = string
  sensitive   = true
}

variable "ami_id" {
  description = "AMI da instancia (Amazon Linux 2023 - ja vem com o SSM Agent)"
  type        = string
  default     = "ami-03081c3f9c48b414e"
}

variable "instance_profile" {
  description = "Instance profile da EC2 (precisa de ECR ReadOnly + AmazonSSMManagedInstanceCore)"
  type        = string
  default     = "ECR-EC2-Role"
}
