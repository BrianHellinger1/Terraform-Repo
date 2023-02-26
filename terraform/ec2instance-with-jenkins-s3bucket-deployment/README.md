# How AWS Works With Terraform & Jenkins To Simplify CI/CD Projects
![Terraform drawio](https://user-images.githubusercontent.com/105087652/221422884-e438ce89-fa91-467b-b66b-ef8cc144f262.png)

- [Medium Article](https://medium.com/@bphellinger/how-aws-works-with-terraform-jenkins-to-simplify-ci-cd-projects-4fdce618c549)

## Objectives:

### - Deploy 1x EC2 Instance in your Default VPC
### - Bootstrap the EC2 instance with a script that will install and start Jenkins
### - Create and assign a Security Group to the Jenkins Security Group that allows traffic on port 22 from your IP and allows traffic from port 8080
### - Create an S3 bucket for your Jenkins Artifacts that is not open to the public

## Commands Used In Project:

### Current terraform version
`terraform --version`

### Current AWS version
`aws --version`

### AWS Configure for account
`aws configure`

### Directory Creation
`mkdir directory_name`

### Enter into directory to create main.tf file
`cd directory_name`

### Create main.tf file
`touch main.tf`

### Intialize terraform directory
`terraform init`

### Validate code inside the main.tf file
`terraform validate`

### Preview terraform creation
`terraform plan`

### Apply changes within terraform
`terraform apply`

### Output the terraform state file
`terraform state list`

### Destory infrstructure that was created
`terraform destroy`
