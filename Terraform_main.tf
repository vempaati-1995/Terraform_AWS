#Instance creation
resource "aws_instance" "webserver" {
  count                       = var.instance_count
  ami                         = "ami-04e35eeae7a7c5883"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "Terraform-${count.index}"
  }
}

#Bucket creation
resource "aws_s3_bucket" "sri1995" {
  bucket = "finanace-1995"
  tags = {
    Description = "Finance and Payroll"
  }
}

#User creation
resource "aws_iam_user" "admin-user" {
  name = "lucy"
  tags = {
    Description = "Team Leader"
  }
}

#Policy permissions
resource "aws_iam_policy" "example_policy" {
  name        = "MyExamplePolicy"
  description = "Example IAM policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject"],
        Resource = ["arn:aws:s3:::my-bucket/*"]
      },
      {
        Effect   = "Allow",
        Action   = ["ec2:DescribeInstances"],
        Resource = ["*"]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "example_attachment" {
  user       = "lucy"
  policy_arn = aws_iam_policy.example_policy.arn
}

// VPC Resource
resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_vpc-cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.aws_vpc_name
  }
}

// Public Subnet Resource
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.aws_subnet_public_cidr

  tags = {
    Name = var.aws_subnet_name_public
  }
}

// Internet Gateway
resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.aws_igw_name
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet]

}

// IGW Route table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }

  tags = {
    Name = var.aws_roting_table_name
  }
}

resource "aws_route_table_association" "route_table" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public_route.id
}

//security groups
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
