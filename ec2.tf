
#creating aws_Web_instance
resource "aws_instance" "webserver" {
  ami           =  "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  #availability_zone = "${element(var.azs,count.index)}"
  availability_zone = "us-east-1a"
  key_name = "laptopkey"
  #subnet_id = "${element(aws_subnet.testing_sub.*.id,count.index)}"
  subnet_id = "${aws_subnet.Webserver.id}"
  vpc_security_group_ids = ["${aws_security_group.webSG.id}"]
  private_ip = "10.0.1.100"
  associate_public_ip_address = true	
  tags = {
    Name = "WebServer"
  }
}


#creating aws__instance
resource "aws_instance" "webserverBastion" {
  ami           =  "ami-07817f5d0e3866d32"
  instance_type = "t2.micro"
  #availability_zone = "${element(var.azs,count.index)}"
  availability_zone = "us-east-1a"
  key_name = "laptopkey"
  #subnet_id = "${element(aws_subnet.testing_sub.*.id,count.index)}"
  subnet_id = "${aws_subnet.Webserver.id}"
  vpc_security_group_ids = ["${aws_security_group.BastionSG.id}"]
  private_ip = "10.0.1.200"
  associate_public_ip_address = true	
  tags = {
    Name = "WebServer_Bastion"
  }
}

#creating aws__instance
resource "aws_instance" "DBserver" {
  ami           =  "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  #availability_zone = "${element(var.azs,count.index)}"
  availability_zone = "us-east-1a"
  key_name = "laptopkey"
  #subnet_id = "${element(aws_subnet.testing_sub.*.id,count.index)}"
  subnet_id = "${aws_subnet.Database.id}"
  vpc_security_group_ids = ["${aws_security_group.DBSG.id}"]
  private_ip = "10.0.2.100"
  associate_public_ip_address = true	
  tags = {
    Name = "DBserver"
  }
}
# resource "null_resource" "dockerinstall"{
#      depends_on = ["aws_instance.devops_test"]
#     count = "${length(aws_subnet.testing_sub)}" 
#      provisioner "remote-exec"{
#          connection{
#           type = "ssh"
#           user = "ec2-user"
#           private_key = "${file("C:/Users/sitar/Downloads/laptopkey.pem")}"
#           host = "${element(aws_instance.devops_test.*.public_ip,count.index)}"
#           #host  = "${aws_instance.devops_test.public_ip}"
#       }
#       inline = [

#           "sudo yum update -y",
#           " sudo amazon-linux-extras install nginx1 -y",
#           "sudo systemctl start nginx",
#           "sudo yum update -y",
#           "sudo amazon-linux-extras install docker -y",
#           "sudo yum install docker -y",
#           "sudo service docker start ",
#           "sudo usermod -aG docker ec2-user",
#           "sudo docker info"

#       ]
#   }
#   #depends_on = [aws_instance.devops_test]
# }