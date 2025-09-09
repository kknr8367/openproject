variable "ami_id" {
  default = "ami-0c55b159cbfafe1f0" # Ubuntu AMI
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
variable "key_name" {
  default = "k8s.pem"
}
