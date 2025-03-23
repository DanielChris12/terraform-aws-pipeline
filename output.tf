# Outputs
output "ec2_public_ip" {
  value = aws_instance.my_ec2_instance1.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_s3_bucket.id
}

output "rds_endpoint" {
  value = aws_db_instance.my_rds.endpoint
}
output "ACCESS_YOUR_JENKINS_HERE" {
  value = "http://${aws_instance.my_ec2_instance1.public_ip}:8080"
}
