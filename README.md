# tf-vpc-subnet-ec2-nginx

This Repo has Terraform Configuration files that Provision Infrastructure on AWS.

It creates the following - 
a. VPC
b. Subnet
c. EC2 Instance
d. Using provisioner - file - Installs - nginx server
e. Using provisioner - remote-exec - makes .sh file Executable and Runs it on Remote Server
f. Using provisioner - local-exec - Logs the IP Address of the Remote Server
