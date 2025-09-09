variable "ami_id" {
  default = "ami-0c55b159cbfafe1f0" # Ubuntu AMI
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "k8s.pem"
}
