//Outputs for the template, you can call these in the main output file. Without them it will
//break
output "public_ip"{
    value = aws_instance.test-server.public_ip
}