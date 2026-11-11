resource "aws_instance" "locals"{
count = length(local.instance_name)
    ami = local.ami_id
    instance_type = local.instance_type
    vpc_security_group_ids = [aws_security_group.locals[count.index].id]

    tags = merge(local.common_tags,  {
        Name = "${local.instance_name[count.index]}_server"
    } )
        

}

resource "aws_security_group" "locals" {

count = length(local.instance_name)

    name = "sg for - ${local.instance_name[count.index]}"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

        egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

tags = merge(local.common_tags, {
    Name = "${local.instance_name[count.index]} server-sg"
})  
}