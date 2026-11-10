resource "aws_instance" "terraform_server" {
    for_each = var.instance_name
    ami = var.ami_id
    instance_type = each.value.instance_type
    vpc_security_group_ids = [aws_security_group.sg[each.key].id,aws_security_group.sg_common.id]

/* /* tags = {
    # Name = "${var.project}-${var.environment}-${var.instance_name[count.index]}"
}
 */ 
tags = merge (

    var.common_tags, {Name = "${var.project}-${var.environment}-${each.key}-sg"}
)
}

resource "aws_security_group" "sg_common" {
    name = "${var.project}-${var.environment}-common-sg"
    description = "security group for ${var.project}-${var.environment}-common-server"

    ingress {
        from_port  = 22
        to_port    = 22
        protocol   = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks=["0.0.0.0/0"]
    }

    tags = merge (

    var.common_tags, {Name = "${var.project}-${var.environment}-common-sg"}
)

}


resource "aws_security_group" "sg" {
    for_each = var.instance_name
    name = "${var.project}-${var.environment}-${each.key}-sg"
    description = "security group for ${var.project}-${var.environment}-${each.key}-server"

   dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
        from_port  = ingress.value.port
        to_port    = ingress.value.port
        protocol   = "tcp"
        cidr_blocks = ingress.value.cidr_blocks

    }
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

output "server_ips" {
  # This creates a custom map: key => value
  value = { for key, instance in aws_instance.terraform_server : key => instance.public_ip }
}

output "sg_ids" {
  # This creates a custom map: key => value
  value = { for key, sg in aws_security_group.sg : key => sg.id }
  
}

output "domain_records" {
  # This creates a custom map: key => value
  value = { for key, domain in aws_route53_record.updatingrecord : key => domain.name} 
  
}

