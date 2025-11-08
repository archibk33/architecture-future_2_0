terraform {
	required_version = ">= 1.5.0, < 2.0.0"
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 5.0"
		}
	}
}

provider "aws" {
	region = var.aws_region
}

# VPC и сеть
resource "aws_vpc" "main" {
	cidr_block           = var.vpc_cidr
	enable_dns_support   = true
	enable_dns_hostnames = true
	tags = {
		Name    = "${var.project}-vpc"
		Project = var.project
	}
}

resource "aws_internet_gateway" "igw" {
	vpc_id = aws_vpc.main.id
	tags = {
		Name    = "${var.project}-igw"
		Project = var.project
	}
}

resource "aws_subnet" "public" {
	vpc_id                  = aws_vpc.main.id
	cidr_block              = var.public_subnet_cidr
	map_public_ip_on_launch = true
	availability_zone       = var.public_az
	tags = {
		Name    = "${var.project}-public-subnet"
		Project = var.project
	}
}

resource "aws_subnet" "private" {
	vpc_id            = aws_vpc.main.id
	cidr_block        = var.private_subnet_cidr
	availability_zone = var.private_az
	tags = {
		Name    = "${var.project}-private-subnet"
		Project = var.project
	}
}

resource "aws_eip" "nat" {
	domain = "vpc"
	tags = {
		Name    = "${var.project}-nat-eip"
		Project = var.project
	}
}

resource "aws_nat_gateway" "nat" {
	allocation_id = aws_eip.nat.id
	subnet_id     = aws_subnet.public.id
	tags = {
		Name    = "${var.project}-nat"
		Project = var.project
	}
	depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
	vpc_id = aws_vpc.main.id
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.igw.id
	}
	tags = {
		Name    = "${var.project}-public-rt"
		Project = var.project
	}
}

resource "aws_route_table_association" "public" {
	subnet_id      = aws_subnet.public.id
	route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
	vpc_id = aws_vpc.main.id
	route {
		cidr_block     = "0.0.0.0/0"
		nat_gateway_id = aws_nat_gateway.nat.id
	}
	tags = {
		Name    = "${var.project}-private-rt"
		Project = var.project
	}
}

resource "aws_route_table_association" "private" {
	subnet_id      = aws_subnet.private.id
	route_table_id = aws_route_table.private.id
}

# Безопасность
resource "aws_security_group" "ec2_sg" {
	name        = "${var.project}-ec2-sg"
	description = "Доступ к ВМ по SSH и HTTP"
	vpc_id      = aws_vpc.main.id

	ingress {
		description = "SSH"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = [var.ssh_ingress_cidr]
	}

	ingress {
		description = "HTTP"
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name    = "${var.project}-ec2-sg"
		Project = var.project
	}
}

# Виртуальная машина
resource "aws_instance" "app" {
	ami                    = var.ec2_ami
	instance_type          = var.ec2_instance_type
	subnet_id              = aws_subnet.public.id
	vpc_security_group_ids = [aws_security_group.ec2_sg.id]
	key_name               = var.ssh_key_name

	tags = {
		Name    = "${var.project}-app"
		Project = var.project
	}
}

# Дополнительный диск и присоединение
resource "aws_ebs_volume" "data" {
	availability_zone = var.public_az
	size              = var.ebs_size_gb
	tags = {
		Name    = "${var.project}-data-disk"
		Project = var.project
	}
}

resource "aws_volume_attachment" "data_attach" {
	device_name = "/dev/sdf"
	volume_id   = aws_ebs_volume.data.id
	instance_id = aws_instance.app.id
}

# Объектное хранилище
resource "aws_s3_bucket" "raw" {
	bucket = "${var.project}-raw-${random_id.bucket_suffix.hex}"
	tags = {
		Name    = "${var.project}-raw"
		Project = var.project
	}
}

resource "random_id" "bucket_suffix" {
	byte_length = 4
}


