resource "aws_security_group" "linux_sg" {

 name = "linux-server-sg"

 ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
   from_port = 3306
   to_port = 3306
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}
locals {
 server_names = ["web","app","db"]
}

resource "aws_instance" "servers" {

 count = 3

 ami = "ami-00d2dbb426772b03a"

 instance_type = var.instance_type

 key_name = "terraform-key"

 vpc_security_group_ids = [
   aws_security_group.linux_sg.id
 ]

 tags = {
   Name = local.server_names[count.index]
 }
}
