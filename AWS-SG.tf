resource "aws_security_group" "my-new-security-group" {
name = "web_server_inbound"
description = "Allow inbound traffic on tcp/443"
vpc_id = aws_vpc.vpc.id
