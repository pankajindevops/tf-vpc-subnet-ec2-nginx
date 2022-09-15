
variable "AWS_REGION" {

  default = "eu-west-2"
}

variable "PRIVATE_KEY_PATH" {

  // default = "london-region-key-pair"
  default = "/home/pankajsharma/terraform/tf-vpc-subnet-ec2/key-pair"

}

variable "PUBLIC_KEY_PATH" {

  // default = "london-region-key-pair.pub"
  default = "/home/pankajsharma/terraform/tf-vpc-subnet-ec2/key-pair.pub"
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
