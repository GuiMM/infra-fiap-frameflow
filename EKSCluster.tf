resource "aws_eks_cluster" "frameFlowEksCluster" {
  name     = "frameFlow-eks-cluster"
  role_arn = data.aws_iam_role.frameFlowIamRole.arn

  vpc_config {

    subnet_ids = [aws_subnet.subnetA.id, aws_subnet.subnetB.id]
    security_group_ids = [aws_security_group.clusterSG.id]
  }

  tags = {
    Name = var.clusterTag
  }

  access_config {
    authentication_mode = var.accessConfig
  }
 
}
