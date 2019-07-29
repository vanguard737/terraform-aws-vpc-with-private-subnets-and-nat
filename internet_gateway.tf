# allow internet access to nat #1
resource "aws_route_table" "public_web_to_internet" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "WEB subnet to Internet through internet gateway"
  }
}

resource "aws_route_table_association" "internet_for_public_web" {
  route_table_id = aws_route_table.public_web_to_internet.id
  subnet_id      = aws_subnet.public_web.id
}
