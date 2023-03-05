#create a new VPC for week21 project
resource "aws_vpc" "LUProject_Week21_VPC" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "Brians_ProjectWeek21_VPC"
  }
}

#create internet gateway
resource "aws_internet_gateway" "Project_Week21_internet_gateway" {
  vpc_id = aws_vpc.LUProject_Week21_VPC.id

  tags = {
    Name = "Project_Week21_gateway"
  }
}

#create public route table
resource "aws_route_table" "Project_week21_public_routetable" {
  vpc_id = aws_vpc.LUProject_Week21_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Project_Week21_internet_gateway.id
  }
}


#AWS availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

#deploy two subnets to the VPC
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.LUProject_Week21_VPC.id
  cidr_block              = "172.16.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.LUProject_Week21_VPC.id
  cidr_block              = "172.16.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]
}


#create security groups
resource "aws_security_group" "Project_week21_security_group" {
  name        = "Project-week21-security-group"
  description = " Project week21 security group"
  vpc_id      = aws_vpc.LUProject_Week21_VPC.id

  ingress {
    description = "HTTPS from web"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Project-week21_security_group"
  }
}

resource "aws_autoscaling_group" "Week21_autoscaling" {
  vpc_zone_identifier       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  launch_configuration      = aws_launch_configuration.Week21_Config.name
  desired_capacity          = 2
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "EC2"

  tag {
    key                 = "Name"
    value               = "Project-week21 ec2 instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

#launch EC2 Instances with Apache install configuration
resource "aws_launch_configuration" "Week21_Config" {
  name_prefix     = "Week21-Project-"
  image_id        = "ami-006dcf34c09e50022"
  instance_type   = "t2.micro"
  user_data       = file("apache-install.sh")
  security_groups = [aws_security_group.Project_week21_security_group.id]
}

