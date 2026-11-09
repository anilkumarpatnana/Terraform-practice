resource "aws_instance" "terraform_server" {
    count = length(var.instance-name)
    ami = var.ami-id
    instance_type = var.instance-type
    security_groups = [aws_security_group.sg[count.index].name]

 tags = {
    Name = var.instance-name[count.index]
 }
}


resource "aws_security_group" "sg" {
    count = length(var.instance-name)
    name = "${var.instance-name[count.index]}-sg"
    description = "security group for ${var.instance-name[count.index]}-server"

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

}

resource "aws_route53_record" "updatingrecord" {
  count = length(var.instance-name)
  name = "${var.instance-name[count.index]}.${var.domain-name}"
  type = "A"
  ttl = 1
  zone_id = var.zone-id
  records = [aws_instance.terraform_server[count.index].private_ip]

}