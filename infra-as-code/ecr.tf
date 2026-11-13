resource "aws_ecr_repository" "ecr_site" {
  name                 = "supereofim"
  image_tag_mutability = "MUTABLE"

  # Permite o terraform destroy apagar o repositorio mesmo com imagens dentro
  force_delete = true
}