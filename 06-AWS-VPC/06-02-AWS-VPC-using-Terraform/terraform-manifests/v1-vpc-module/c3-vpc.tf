# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.78.0"  
  # version = "~> 2.78"

  # VPC Basic Details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"   
  azs                 = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database Subnets
  create_database_subnet_group = true
  create_database_subnet_route_table= true
  database_subnets    = ["10.0.151.0/24", "10.0.152.0/24"]

  # the below parameters creates NAT and Internet gateway for the database subnet
  # As that is not needed in this specific case, it is being set to false

  #create_database_nat_gateway_route = true
  #create_database_internet_gateway_route = true

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true

  # Note - the below parameyers if being set false will create 1 NAT gateway in every availability zone
  single_nat_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true # this ensures that instances with public IPV4 address gets public DNS
  enable_dns_support = true # this ensures that the DNS resolution succeds via AWS provised DNS server

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = {
    Owner = "paymatrix"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}



