locals {
  custom-tags = {
    miantainedby = "suman"
    ENV          = "PROD"
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_role" "EKS_Role" {
  name               = "EKS-Role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

resource "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(local.custom-tags, { Name = "vpc-main" })
}

resource "aws_subnet" "public_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "cluster-subnet-${count.index}"
  }
}

resource "aws_eks_cluster" "cluster-1" {
  name     = "static-web-cluster"
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = aws_subnet.public_subnet[*].id
  }
  tags = local.custom-tags
}
