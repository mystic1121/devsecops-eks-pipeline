output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "ecr_frontend_repo" {
  value = aws_ecr_repository.frontend.repository_url
}

output "ecr_backend_repo" {
  value = aws_ecr_repository.backend.repository_url
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
