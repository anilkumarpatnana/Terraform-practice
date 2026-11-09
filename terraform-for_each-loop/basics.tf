resource "aws_instance" "terraform_server" {
    for_each = var.instance_name
    ami = var.ami_id
    instance_type = each.value.instance_type
    security_groups = [aws_security_group.sg[each.key].name]

/* /* tags = {
    # Name = "${var.project}-${var.environment}-${var.instance_name[count.index]}"
}
 */ 
tags = merge (

    var.common_tags, {Name = "${var.project}-${var.environment}-${each.key}-sg"}
)
}


resource "aws_security_group" "sg" {
    for_each = var.instance_name
    name = "${var.project}-${var.environment}-${each.key}-sg"
    description = "security group for ${var.project}-${var.environment}-${each.key}-server"

    ingress {
        from_port  = each.value.port
        to_port    = each.value.port
        protocol   = "tcp"
        cidr_blocks = each.value.cidr_blocks
    }

    egress {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks=["0.0.0.0/0"]
    }

    tags = merge (

    var.common_tags, {Name = "${var.project}-${var.environment}-${each.key}-sg"}
)


}

resource "aws_route53_record" "updatingrecord" {
  for_each = var.instance_name
  name = "${var.project}.${var.environment}.${each.key}.${var.domain_name}"
  type = "A"
  ttl = 1
  zone_id = var.zone_id
  records = [aws_instance.terraform_server[each.key].private_ip]
}