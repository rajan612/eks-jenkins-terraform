terraform {
  backend "s3" {
    bucket = "terraform-eks-cicd"
    key    = "eks/terraform-tfstate"
    region = "us-east-1"
  }
}