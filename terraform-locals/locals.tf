locals {
    instance_name = ["locals-1","locals-2","locals-3"]
    ami_id = "ami-0055977a6e828a4f4"
    instance_type = "t3.micro"
    common_tags = {
        project = "locals"
        environment = "dev"
    }
}