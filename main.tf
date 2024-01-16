# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.public_subnets

  enable_dns_hostnames = true

  tags = {
    Name        = "Jenkins-VPC"
    terraform   = "true"
    Environment = "dev"
  }
}


#SG

#EC2 instance