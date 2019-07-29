# NAT gateway
resource "aws_eip" "nat" {
  count = local.nat_gw ? 1 : 0
}

resource "aws_nat_gateway" "nat" {
  count         = local.nat_gw ? 1 : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_web.id
}


// aws --region us-west-2 ec2 describe-images --owners amazon --filters Name="name",Values="amzn-ami-vpc-nat*"
data "aws_ami" "nat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }

  owners = ["amazon"]
}

# NAT instance
resource "aws_instance" "nat" {
  count                       = local.nat_instance ? 1 : 0
  ami                         = data.aws_ami.nat.id
  instance_type               = var.nat_instance_type
  source_dest_check           = false
  subnet_id                   = aws_subnet.public_web.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.access_via_nat[count.index].id]

  tags = {
    Name = "NAT"
  }
}


