provider "aws" {  
  region                   = "us-east-1"
}

data "aws_ami" "ubuntu" {    
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
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

resource "aws_s3_bucket" "terraform_state" {
  bucket_prefix = "learn-s3-remote-backend-"

  versioning {
    enabled = true
  }

  force_destroy = true

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock-dynamo"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}