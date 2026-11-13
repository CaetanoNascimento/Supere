resource "aws_ecr_repository" "ecr_site" {
  name                 = "supereofim"
  image_tag_mutability = "MUTABLE"
}