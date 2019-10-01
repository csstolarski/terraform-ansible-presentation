
//The module files hold 'templates' or 'classes' of resources that you can create.
//There isn't a limit to what you can put in these, you could define your whole vpc in here.


//here we define a ec2-instance and pass variables in from the variable file.
resource "aws_instance" "test-server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  tags                   = var.tags
  security_groups        = var.security_groups
}