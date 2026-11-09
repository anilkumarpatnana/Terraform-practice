resource "aws_instance" "practice_servers" {
    ami = "ami-0055977a6e828a4f4"
    instance_type = "t3.micro"
    security_groups = [aws_security_group.sg.name]

 tags = {
    Name = "practice_servers"
 }
}


resource "aws_security_group" "sg" {
    name = "practice_servers_sg"
    description = "security group for practice_servers"

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
  name = "practice_servers.anilkumarpatnana.online"
  type = "A"
  ttl = 1
  zone_id = "Z0932076Y9TWK3RWNWAE"
  records = [aws_instance.practice_servers.private_ip]
  
}