resource "aws_instance" "provisioners" {

    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.provisioners-sg.id]

    tags = {
        Name = "provisioners-server"
    }

connection {
      type = "ssh"
      user = "ec2-user"
      password = "DevOps321"
      host = self.public_ip
    }


provisioner "file" {

    source = "frontend/frontend.sh"
    destination = "/home/ec2-user/frontend.sh"
  
}


        provisioner "remote-exec" {

     inline = [
          "sudo chmod +x /home/ec2-user/frontend.sh",
          "sudo sh frontend.sh"
     ]
    }



}

output "provisioner-server-public_ip" {

    value = aws_instance.provisioners.public_ip
  
}

resource "aws_security_group" "provisioners-sg" {

    name = "provisioners-sg"


    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

        egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
tags =  {

    Name = "provisioners-server-sg"

}
  
}
