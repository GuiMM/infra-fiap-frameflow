variable "projectName" {
  default = "frameFlow"
}

variable "accessConfig" {
  type = string
  default = "API_AND_CONFIG_MAP"
}

variable "clusterName" {
  type = string
  default = "clusterEksFrameFlow"
}

variable "instanceNodeType" {
  default = "t3.medium"
}

//teremos que passar via secret
variable "arnNumber" {
  default = "090111931170"
}

variable "policyAccessCluster" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "clusterTag" {
  default = "FrameFlowEksCluster"
}
variable "region" {
  default = "us-east-1"
  
}
variable "topicVideoLoadName" {
  default = "video-carregado-topic.fifo"

}

variable "queueVideoLoadName" {
  default = "video-carregado-subscriber-queue.fifo"

}

variable "topicVideoStatusName" {
  default = "video-status-topic.fifo"

}

variable "queueVideoStatusName" {
  default = "video-status-subscriber-queue.fifo"

}

