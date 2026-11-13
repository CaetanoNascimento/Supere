output "instance_id" {
  description = "ID da instancia (alvo do deploy via SSM)"
  value       = aws_instance.website_server.id
}

output "public_ip" {
  description = "IP publico do site"
  value       = aws_instance.website_server.public_ip
}
