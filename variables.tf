variable "ami_id" {
  type = string
  default = "ami-00ca32bbc84273381" # Ubuntu AMI
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "k8s.pem"
}