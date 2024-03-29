pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
        stages {
            stage ("Checkout SCM"){
                steps{
                    script{
                        checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rajan612/eks-jenkins-terraform.git']])
                    }
                }
            }
            stage ("Initializing Terraform"){
                steps{
                    script{
                        dir('eks'){
                            sh 'terraform init'
                        }
                        
                    }
                }
            }
            stage ("Formatting Terraform code"){
                steps{
                    script{
                        dir('eks'){
                            sh 'terraform fmt'
                        }
                        
                    }
                }
            }
            stage ("Validate Terraform code"){
                steps{
                    script{
                        dir('eks'){
                            sh 'terraform validate'
                        }
                        
                    }
                }
            }
            stage ("Previwing the Terraform Infra"){
                steps{
                    script{
                        dir('eks'){
                            sh 'terraform plan'
                        }
                        input (message: " Are you OK to proceed", OK: "Proceed")
                    }
                }
            }
            stage ("Creating or Destroying the EKS Cluster"){
                steps{
                    script{
                        dir('eks'){
                            sh "echo Choice : ${params.action}" 
                            sh "terraform ${params.action} --auto-approve"
                        }
                        
                    }
                }
            }
            stage ("Deploying nginx application"){
                steps{
                    script{
                        dir('eks/configurationfiles'){
                            sh 'aws eks update-kubeconfig --name my-eks-cluster'
                            sh 'kubectl apply -f deployment.yaml'
                            sh 'kubectl apply -f service.yaml'
                        }
                        
                    }
                }
            }            
    }
}