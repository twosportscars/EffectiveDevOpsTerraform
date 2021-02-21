# Provider Configuration for AWS
provider "aws" {
  region = "us-east-1"
}

# Resource Configuration for AWS
resource "aws_instance" "myserver" {
  ami = "ami-0d46c224f92361863"
  instance_type = "t4g.micro"
  key_name = "EffectiveDevOpsAWS"
  vpc_security_group_ids = ["sg-935042e7"]
  subnet_id = "subnet-9a01c4ec"

  tags = {
    Name = "helloworld"
  }

# Provisioner for applying Ansible playbook in Pull mode
  provisioner "remote-exec" {
    connection {
      host = "${aws_instance.myserver.public_ip}"
      user = "ec2-user"
      private_key = "${file("~/.ssh/EffectiveDevOpsAWS.pem")}"
    }
    inline = [
      "sudo ansible-pull -U https://github.com/twosportscars/ansible helloworld.yml -i localhost"
    ]
  }

}

# IP address of newly created EC2 instance
output "myserver" {
 value = "${aws_instance.myserver.public_ip}"
}
