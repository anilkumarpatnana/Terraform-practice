variable "ami-id" {
    type = string
    default = "ami-0055977a6e828a4f4"  
}

variable "instance-type" {
    type = string
    default = "t3.micro"
}

variable "instance-name"{
    type = list
    default = ["terraform-server","Ansible-server","Linux-server"]
}

variable "zone-id" {
    type = string
    default = "Z0932076Y9TWK3RWNWAE"
}

variable "domain-name" {
    type = string
    default = "anilkumarpatnana.online"
  
}