variable "ami_id" {
    type = string
}

variable "instance_type" {
    type = string

    validation {
      condition = contains(["t3.micro","t3.small","t3.medium"], var.instance_type)
      error_message = "The instance-type must be t3.micro, t3.small, t3.medium"
    }
}

variable "instance_name"{
    type = list
}

variable "zone_id" {
    type = string
}

variable "domain_name" {
    type = string  
}

variable "project" {
    type = string
}

variable "environment" {
    type = string
}

variable "common_tags"{
    type = map
}