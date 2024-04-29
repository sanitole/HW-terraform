output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.group-3.public_ip
}

output "ec2_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.group-3.private_ip
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.wordpress_db.endpoint
}

output "rds_address" {
  description = "The DNS of the RDS instance"
  value       = aws_db_instance.wordpress_db.address
}