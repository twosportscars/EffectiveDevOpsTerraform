# Provider Configuration for AWS
provider "aws" {
  region     = "us-east-1"
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

# Provisioner for applying Ansible playbook
  provisioner "remote-exec" {
    connection {
      host = "${aws_instance.myserver.public_ip}"
      user = "ec2-user"
      private_key = "${file("~/.ssh/EffectiveDevOpsAWS.pem")}"
    }
  }
  
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' > ./myinventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i myinventory --private-key=~/.ssh/EffectiveDevOpsAWS.pem helloworld.yml"
  }  
}

# IP address of newly created EC2 instance
output "myserver" {
 value = "${aws_instance.myserver.public_ip}"
}