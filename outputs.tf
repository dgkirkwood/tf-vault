output "public_ip" {
  value       = aws_instance.vault.public_ip
  description = "The public IP of the Instance"
}
