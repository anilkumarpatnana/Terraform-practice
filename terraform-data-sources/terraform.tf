resource "aws_instance" "data-sources" {

    ami = data.aws_ami.ami-id.image_id
    instance_type = "t3.micro"
    vpc_security_group_ids = [data.aws_security_group.sg-id.id]

    tags = {
        Name = "data-sources-instance"
    }
  
}

data "aws_ami" "ami-id" {

    most_recent = true
    owners = ["973714476881"]

    filter {
        name = "name"

        values =["Redhat-9-DevOps-Practice"]
    }


  
}

data "aws_security_group" "sg-id" {

  filter {
    name ="group-name"
    values = ["roboshop-common-ssh"]
  }
}