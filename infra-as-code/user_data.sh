#!/bin/bash
dnf update -y
dnf install -y docker
systemctl enable --now docker
usermod -a -G docker ec2-user

# O SSM Agent ja vem no Amazon Linux 2023; garante que esta ativo
systemctl enable --now amazon-ssm-agent
