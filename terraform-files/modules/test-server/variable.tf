//These blank variables are filled in when you call the module in the main - main terraform file
variable "instance_type" {}
variable "ami" {}
variable "key_name" {}
variable "tags"{
    type = map(string)
}
variable  "security_groups"{
    type = list(string)
}