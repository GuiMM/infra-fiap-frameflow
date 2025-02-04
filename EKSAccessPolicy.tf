//associando politicas de acesso ao usuario para termos acesso(adm) aos recursos do cluster

resource "aws_eks_access_policy_association" "example" {
  cluster_name  = aws_eks_cluster.frameFlowEksCluster.name
  policy_arn    = var.policyAccessCluster
  principal_arn = "arn:aws:iam::${var.arnNumber}:role/voclabs"

  access_scope {
    type       = "cluster"
  }
  

  # authentication {
  #   type = "oidc"
  #   config = {
  #     authentication_mode = "API_AND_CONFIG_MAP"
  #   }
  # }
}