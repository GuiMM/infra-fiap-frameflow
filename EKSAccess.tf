//Criando acesso ao cluster
resource "aws_eks_access_entry" "access" {
    cluster_name = aws_eks_cluster.frameFlowEksCluster.name
    principal_arn = "arn:aws:iam::${var.arnNumber}:role/voclabs"
    kubernetes_groups = ["fiap-frameFlow","pos-tech"]
    
}