module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0" # this is module version

  name               = local.common_name_suffix
  # kubernetes_version = "1.33"
  kubernetes_version = var.eks_version

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
    metrics-server = {}
  }