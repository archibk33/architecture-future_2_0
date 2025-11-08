output "vpc_id" {
	description = "VPC"
	value       = aws_vpc.main.id
}

output "public_instance_public_ip" {
	description = "адрес ВМ"
	value       = aws_instance.app.public_ip
}

output "raw_bucket_name" {
	description = "Имя бакета "
	value       = aws_s3_bucket.raw.bucket
}


