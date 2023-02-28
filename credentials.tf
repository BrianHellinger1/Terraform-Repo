provider "aws" {
2 access_key = "<YOUR_ACCESSKEY>"
3 secret_key = "<YOUR_SECRETKEY>"
4 region = "<REGION>"
5 }
6
7 resource "aws_instance" "web" {
8 ami = "<AMI>"
9 instance_type = "t2.micro"
10
11 subnet_id = "<SUBNET>"
12 vpc_security_group_ids = ["<SECURITY_GROUP>"]
13
14 tags = {
15 "Identity" = "<IDENTITY>"
16 }
17 }
