variable "instance_type" {
  type = map
  default = {
    dev = "t3.micro"
    test = "t3.small"
    prod = "t3.medium"
  }
}