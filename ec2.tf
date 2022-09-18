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
  key_name = aws_key_pair.key-pair-01.id

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

    user        = var.EC2_USER
    private_key = file("${var.PRIVATE_KEY_PATH}")
  }

}

# key-pair-01 & key_name = "key-pair-01" should Match the Actual Key Pair name
resource "aws_key_pair" "key-pair-01" {

  key_name   = "key-pair-01"

  // public_key = file("${var.PUBLIC_KEY_PATH}")
  # It seems that the content of the key needs to be given, 
  # not the path: public_key = "${file("${path.root}/terraform-keys2.pub")}" should work 
  
  # This works - public_key = "key-pair-01" // ie. the actual file name
  
  // public_key = "/home/pankajsharma/terraform/keys/key-pair-01.pub"
  // public_key = "${file("/home/pankajsharma/terraform/keys/key-pair-01.pub")}"
  
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAZixG2lccPNViHAWLGWXJTlba6xKHrYj83xxq5V+ycIY18IbSF+jC1sNvreLQv477CHDOV3DnezYLFWSnYCXMGaNwOl4uftSyN1Exdliybr1/mcreriOwn4K24g9tyWhbWa0XRwPZfpVGQiXeYLjZkbCaL3OoAh+CTrEWFW40Zu7eupUil/YZEItYPnH4qxA6y+45q1Zbttr2GyfUlSbbO/fHGvm0MloMcW5ROHQvlYQTGoiewka9BYrYGPpseQiH8ztylIz+g9xaWSMYR0dYepbb+b+CON2xdAp0itlFnW9UK7vhDnv7ZTzJylyPlxnEKXQ2zR4o5dpkP0L6D4Y4ixqkAo8mmQQ3FMIv/blYaExO8S3B3sZMXKOObx/zqP330EyKf63s0PF2H/DGVckJAWz0jAfHIzxu4WQmZ7uSWTxzd09NHEMTPxjEA9Q42l1FQHNyMiDuTcfK5j8EJAGUwTNKwVUvuV8B+x33k8TsJ9TwgS4D8TuFlseGE93O6Zc= pankajsharma@pankajsharma-Inspiron-16-5625"

}
