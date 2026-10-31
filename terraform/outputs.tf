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

output "ecr_repository_url" {
  description = "Amazon ECR repository URL"
  value       = aws_ecr_repository.taskmanager.repository_url

}

output "github_actions_role_arn" {
  description = "IAM role assumed by GitHub Actions"
  value       = aws_iam_role.github_actions.arn
}