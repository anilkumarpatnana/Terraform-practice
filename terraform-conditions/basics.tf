resource "aws_instance" "terraform_server" {
    count = length(var.instance_name)
    ami = var.ami_id
    instance_type = var.instance_type
    security_groups = [aws_security_group.sg[count.index].name]

/* /* tags = {
    # Name = "${var.project}-${var.environment}-${var.instance_name[count.index]}"
}
 */ 
tags = merge (

    var.common_tags, {Name = var.instance_name[count.index]}
)
}


resource "aws_security_group" "sg" {
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

    tags = merge (

    var.common_tags, {component = "${var.instance_name[count.index]}-sg"}
)


}

resource "aws_route53_record" "updatingrecord" {
  count = length(var.instance_name)
  name = "${var.project}.${var.environment}.${var.instance_name[count.index]}.${var.domain_name}"
  type = "A"
  ttl = 1
  zone_id = var.zone_id
  records = [aws_instance.terraform_server[count.index].private_ip]
}