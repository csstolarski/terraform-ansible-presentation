//Upon successful apply, you can output variables here.
//We output the public ip so that we know what ip to use to ssh into the instance
output "public_ip" {
  value = [
    module.test-server-a.public_ip,
    module.test-server-b.public_ip
  ]
}