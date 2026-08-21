module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-eks"
  cluster_version = "1.34"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = [var.admin_ip] # Restrict K8s API server access

  eks_managed_node_groups = {
    nodes = {
      min_size     = 2
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.medium"]
    }
  }
}