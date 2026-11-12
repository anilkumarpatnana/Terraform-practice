resource "aws_instance" "tfvars-approach" {
    count = length(var.instance_name)
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.tfvars-approach[count.index].id]

 tags = {
    Name = "${var.project}-${var.environment}-${var.instance_name[count.index]}"
 }
}


resource "aws_security_group" "tfvars-approach" {
    count = length(var.instance_name)
    name = "${var.project}-${var.environment}-${var.instance_name[count.index]}-sg"
    description = "security group for ${var.project}-${var.environment}-${var.instance_name[count.index]}-server"

    ingress {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks=["0.0.0.0/0"]
    }

    egress {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks=["0.0.0.0/0"]
    }
     tags = {
    Name = "${var.project}-${var.environment}-${var.instance_name[count.index]}-sg"
 }


}

