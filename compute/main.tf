resource "aws_key_pair" "udemy-keypair" {
  key_name   = "udemy-keypair"
  public_key = file("./compute/keypair/my-keypair.pub")
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["final-chatbot-ec2"]
  }

  filter {
    name   = "owner-id"
    values = ["471112789042"] # Amazon official account ID for Amazon Linux
  }

  owners = ["471112789042"] # Amazon's official owner ID
}

resource "aws_instance" "udemy_instance" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.udemy-keypair.key_name
  private_ip = "10.0.3.100"
  subnet_id = var.public_subnet_id
  security_groups = [var.sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "udemy_instance"
  }

}