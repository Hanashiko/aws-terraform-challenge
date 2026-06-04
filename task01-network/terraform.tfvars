aws_region = "eu-west-1"
vpc_name   = "cmtr-mxb1qv4h-01-vpc"
vpc_cidr   = "10.10.0.0/16"

subnets = [
  {
    name = "cmtr-mxb1qv4h-01-subnet-public-a"
    cidr = "10.10.1.0/24"
    az   = "eu-west-1a"
  },
  {
    name = "cmtr-mxb1qv4h-01-subnet-public-b"
    cidr = "10.10.3.0/24"
    az   = "eu-west-1b"
  },
  {
    name = "cmtr-mxb1qv4h-01-subnet-public-c"
    cidr = "10.10.5.0/24"
    az   = "eu-west-1c"
  }
]

igw_name         = "cmtr-mxb1qv4h-01-igw"
route_table_name = "cmtr-mxb1qv4h-01-rt"