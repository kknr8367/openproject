variable "ami_id" {
  type = string
  default = "ami-0c55b159cbfafe1f0" # Ubuntu AMI
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "k8s.pem"
}


variable "subnet_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

