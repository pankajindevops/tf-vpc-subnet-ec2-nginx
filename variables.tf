#File to Input the Variables that will be used across all .tf files

variable "AWS_REGION" {

  default = "eu-west-2"
}

variable "PRIVATE_KEY_PATH" {

  // default = "london-region-key-pair"
  // default = "/home/pankajsharma/terraform/scripts/tf-vpc-subnet-ec2-nginx/key-pair"
  default = "~terraform/scripts/tf-vpc-subnet-ec2-nginx/key-pair"


}

variable "PUBLIC_KEY_PATH" {

  // default = "london-region-key-pair.pub"
  // default = "/home/pankajsharma/terraform/scripts/tf-vpc-subnet-ec2-nginx/key-pair.pub"
  default = "~/terraform/scripts/tf-vpc-subnet-ec2-nginx/key-pair.pub"

}

variable "EC2_USER" {

  default = "ubuntu"
}

variable "AMI" {

  default = {

    eu-west-2 = "ami-0fb391cce7a602d1f"
    us-east-1 = "ami-052efd3df9dad4825"
  }
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "INSTANCE_COUNT" {
  default = 1  
}

