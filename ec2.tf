
resource "aws_instance" "ec2-instance-13-sep-2022" {

  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.micro"

  # VPC
  subnet_id = aws_subnet.prod-subnet-public-1.id

  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

  # the Public SSH Key
    key_name = aws_key_pair.key-pair.id

  # Output the Public IP of EC2 Instance to text file
  provisioner "local-exec" {

    command = "echo ${self.public_ip} > public-ip.txt"
  }


  # nginx installation
  provisioner "file" {
    source      = "nginx.sh"
    destination = "/tmp/nginx.sh"

  }

  provisioner "remote-exec" {

    inline = [

      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]
  }

  connection {

    type = "ssh"
    host = self.public_ip

    user        = var.EC2_USER
    private_key = file("${var.PRIVATE_KEY_PATH}")
  }

}

resource "aws_key_pair" "key-pair" {

  key_name   = "key-pair"
  public_key = file("${var.PUBLIC_KEY_PATH}")
}
