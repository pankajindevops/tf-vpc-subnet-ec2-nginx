# Create AWS EC2 Instance
resource "aws_instance" "ec2-instance" {

  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = var.INSTANCE_TYPE
  count         = var.INSTANCE_COUNT

  # VPC
  subnet_id = aws_subnet.prod-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

  # the Public SSH Key
  #  key_name = aws_key_pair.key-pair-01.id

  key_name = aws_key_pair.key-pair.key_name


  # Output the Public IP of EC2 Instance to text file
  provisioner "local-exec" {

    command = "echo ${self.public_ip} > public-ip.txt"
  }


  # nginx installation
  provisioner "file" {
    source      = "nginx.sh"
    destination = "/tmp/nginx.sh"

  }

  # Make nginx.sh file into an Executable and Run the .sh file
  provisioner "remote-exec" {

    inline = [

      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]
  }

  connection {

    type = "ssh"
    host = self.public_ip

    user = var.EC2_USER

    // private_key = file("${var.PRIVATE_KEY_PATH}")
    private_key = file(var.PRIVATE_KEY_PATH)

  }
}

# key-pair-01 & key_name = "key-pair-01" should Match the Actual Key Pair name
resource "aws_key_pair" "key-pair" {

  key_name = "key-pair"

  # Works fine on Local Terraform Execution but Fails from Jenkins

  //public_key = file("${var.PUBLIC_KEY_PATH}")
  public_key = file(var.PUBLIC_KEY_PATH)

}
