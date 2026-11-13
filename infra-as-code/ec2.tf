## EC2
# Acesso administrativo e deploy via AWS SSM: sem key pair e sem porta 22.
resource "aws_instance" "website_server" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.website_sg.id]
  iam_instance_profile   = var.instance_profile
  user_data              = file("${path.module}/user_data.sh")

  # Exige IMDSv2 (protege as credenciais da role contra SSRF)
  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name        = "website_server"
    Provisioned = "Terraform"
    Cliente     = "SuperEofim"
  }
}

## Security Group
resource "aws_security_group" "website_sg" {
  name   = "website_sg"
  vpc_id = var.vpc_id

  tags = {
    Name        = "website_sg"
    Provisioned = "Terraform"
    Cliente     = "SuperEofim"
  }
}

## Regras de entrada (sem SSH: a porta 22 fica fechada)
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.website_sg.id
  description       = "HTTP publico"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.website_sg.id
  description       = "HTTPS publico"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

## Regra de saida (o SSM Agent e o docker pull precisam de saida HTTPS)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.website_sg.id
  description       = "Saida liberada (SSM, atualizacoes, pull do ECR)"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
