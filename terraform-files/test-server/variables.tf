
variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default  = "ansible-key"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDV3edOyiiHditPTjF+WyioQSBJzVi0dCt8gF6jjQHnAV1kc1vtrjvoUBZV4itXOy0hQpCT3IJOXxzZCclepajnXe08g+xNZoYkCWuezf1R7KghJ2O+mk5JHmom+2kMXE8h62s0xAnSsA4oywFxH6dc+PaUfRAQgXP/2NNjA/GFXAXLNauAP/l8+JEWFzKTVOb8Ib7NY8XWcdYTqJsgqfJqlkcH0NS9o+hvp1b0HQjfR5LrxPi0kk2kqNix1sQzivyrBSSFG+Du2AnK69eMOyZy2W0S+yeD21mMKxhEGXXppldSmFQtNruKIeHb4tDPZQzHovtXWms+d2u5pCqeeiZ/ something@gmail.com"
}

variable "host_ip"{}