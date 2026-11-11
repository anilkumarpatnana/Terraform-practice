resource "aws_instance" "workspaces" {

    ami = data.aws_ami.ami-id.id
    instance_type = lookup(var.instance_type, terraform.workspace)
    vpc_security_group_ids = [data.aws_security_group.sg.id]  

    tags = {
        Name = "workspaces-server-${terraform.workspace}"
    }
}


data "aws_ami" "ami-id" {

    owners = ["973714476881"]
    most_recent = true
    
    filter  {
        name = "name"
        values = ["Redhat-9-DevOps-Practice"]
    }
  
}


data "aws_security_group" "sg" {

    name = "roboshop-common-ssh"
}


resource "aws_s3_bucket" "roboshop-terraform-state"{

        bucket = "roboshop-tf-state-bucket"
}

