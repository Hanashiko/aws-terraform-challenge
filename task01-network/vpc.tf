resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = length(var.subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets[count.index].cidr
  availability_zone = var.subnets[count.index].az

  tags = {
    Name = var.subnets[count.index].name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}