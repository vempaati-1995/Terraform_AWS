variable "aws_region" {
  default = "us-west-2"
}
variable "instance_count" {
  default = 1 # Change this to the desired number of instances
}
variable "aws_vpc-cidr" {
  default = "10.0.0.0/16"
}
variable "aws_subnet_public_cidr" {
  default = "10.0.1.0/24"
}
variable "aws_subnet_private_cidr" {
  default = "10.0.2.0/24"
}
variable "aws_vpc_name" {
  default = "Terraform VPC"
}
variable "aws_subnet_name_public" {
  default = "Terraform Public Subnet"
}
variable "aws_subnet_name_private" {
  default = "Terraform Private Subnet"
}
variable "aws_igw_name" {
  default = "Terraform Internet Gateway"
}
variable "aws_security_group_name" {
  default = "Terraform Security Group"
}
variable "aws_roting_table_name" {
  default = "Terraform rout table"
}
variable "aws_s3_bucket_name" {
  default = "terraform-finance-1995"
}
variable "aws_ngw_name" {
  default = "Terraform NAT"
}
