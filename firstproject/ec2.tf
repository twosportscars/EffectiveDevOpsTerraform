provider "aws" {region = "us-east-1"}

# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-0d46c224f92361863"
  instance_type = "t4g.micro"
  key_name = "EffectiveDevOpsAWS"
  subnet_id = "subnet-9a01c4ec"
  vpc_security_group_ids = ["sg-0b86ca560e4283ab2"]

  tags  = {
    Name = "helloworld"
  }
}


