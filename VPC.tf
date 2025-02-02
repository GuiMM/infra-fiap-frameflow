
#1.Cria VPC
resource "aws_vpc" "frameFlowVpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "frameFlowVPC"
  }
}

#Cria 2 subnets 
resource "aws_subnet" "subnetA" {
  vpc_id            = aws_vpc.frameFlowVpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true    # Habilita a atribuição automática de IP público
  tags = {
    Name = "public-subnet-eks-a"
  }
}
resource "aws_subnet" "subnetB" {
  vpc_id            = aws_vpc.frameFlowVpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"
  map_public_ip_on_launch = true   # Habilita a atribuição automática de IP público
  tags = {
    Name = "public-subnet-eks-b"
  }
  
}

#2 : create IGW
resource "aws_internet_gateway" "myIgw" {
  vpc_id = aws_vpc.frameFlowVpc.id
}

#3 : route Tables for public subnet
resource "aws_route_table" "RTApp" {
  vpc_id = aws_vpc.frameFlowVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIgw.id
  }
}

#4 : route table association public subnet 
resource "aws_route_table_association" "RTAssociationA" {
  subnet_id      = aws_subnet.subnetA.id
  route_table_id = aws_route_table.RTApp.id
}

resource "aws_route_table_association" "publicRTAssociationB" {
  subnet_id      = aws_subnet.subnetB.id
  route_table_id = aws_route_table.RTApp.id
}

