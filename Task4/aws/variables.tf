variable "project" {
	description = "Название проекта для тегов"
	type        = string
}

variable "aws_region" {
	description = "Регион AWS"
	type        = string
	default     = "eu-central-1"
}

variable "vpc_cidr" {
	description = "CIDR блок VPC"
	type        = string
	default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
	description = "CIDR публичной подсети"
	type        = string
	default     = "10.20.1.0/24"
}

variable "private_subnet_cidr" {
	description = "CIDR приватной подсети"
	type        = string
	default     = "10.20.2.0/24"
}

variable "public_az" {
	description = "Зона доступности для публичной подсети и ВМ"
	type        = string
	default     = "eu-central-1a"
}

variable "private_az" {
	description = "Зона доступности для приватной подсети"
	type        = string
	default     = "eu-central-1b"
}

variable "ssh_ingress_cidr" {
	description = "Диапазон для доступа по SSH"
	type        = string
	default     = "0.0.0.0/0"
}

variable "ec2_ami" {
	description = "AMI образ для EC2"
	type        = string
}

variable "ec2_instance_type" {
	description = "Тип EC2"
	type        = string
	default     = "t3.micro"
}

variable "ssh_key_name" {
	description = "Имя SSH ключа в AWS"
	type        = string
}

variable "ebs_size_gb" {
	description = "Размер дополнительного диска ГБ"
	type        = number
	default     = 20
}


