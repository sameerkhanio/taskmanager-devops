output "ec2_public_ip" {
  description = "Public IP of Task Manager EC2"
  value       = aws_instance.app.public_ip
}

output "rds_endpoint" {
  description = "Private PostgreSQL endpoint"
  value       = aws_db_instance.main.endpoint
}

output "rds_address" {
  description = "Private PostgreSQL hostname"
  value       = aws_db_instance.main.address

}