#Apache install on instance
#!/bin/bash

#Install Apache on Amazon Linux 2
yum update -y
yum install -y httpd

#Start and enable Apache service
systemctl start httpd
systemctl enable httpd

#Now if we wanted to create an application load balancer we could enter the below information and add on some HTML with whatever message we wanted. But we don't have that set up

#Check the status of Apache service
systemctl status httpd

#Install and start firewalld
yum install -y firewalld
systemctl start firewalld
systemctl enable firewalld

#Check the status of firewalld
systemctl status firewalld

#Allow HTTP traffic through firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
