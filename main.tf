provider "aws" {  
  region                   = "us-east-1"
}
data "aws_ami" "ubuntu" {    
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
   }

   owners = ["099720109477"]
}
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id 
  instance_type = local.instance_type_map.stage
  count = local.instance_count_map.stage
  tags = {
    Name = "Netology ${count.index + 1 }"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}