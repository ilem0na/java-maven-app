variable "subnet_cidr_block" {
  type = string
  description = "value of cidr block"
  default = "10.0.10.0/24"
}

variable "vpc_cidr_block" {
  type = string
  description = "value of cidr block"
  default = "10.0.0.0/16"
}

variable "avail_zone" {
  type = string
  description = "value of availability zone"
  default = "us-east-1a"
}

variable "env_prefix" {
  type = string
  default = "Dev"

}

variable "instance_type" {
  type = string
  description = "value of instance type"
  default = "t2.micro"
  
}

variable "my_ip" {
  type = string
  description = "value of my ip"
  default = "174.2.68.163/32"
  
}

variable "region" {
    type = string
    description = "value of region"
    default = "us-east-1"
  }

  variable "jenkins_IP" {
    type = string
    description = "value of jenkins ip"
    default = "143.110.212.172/32"
    
  }
