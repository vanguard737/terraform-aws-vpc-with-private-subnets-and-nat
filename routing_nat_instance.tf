# allow internet access to APP nodes through NAT instance
resource "aws_route_table" "nat_instance_app" {
  count  = local.nat_instance ? 1 : 0
  vpc_id = aws_vpc.project.id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat[count.index].id
  }

  tags = {
    Name = "APP subnet to Internet through NAT instance"
  }
}

resource "aws_route_table_association" "app_subnet_to_nat_instance" {
  count          = local.nat_instance ? 1 : 0
  route_table_id = aws_route_table.nat_instance_app[count.index].id
  subnet_id      = aws_subnet.private_app.id
}

# allow internet access to DB nodes through NAT instance
resource "aws_route_table" "nat_instance_db" {
  count  = local.nat_instance ? 1 : 0
  vpc_id = aws_vpc.project.id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat[count.index].id
  }

  tags = {
    Name = "DB subnet to Internet through NAT instance"
  }
}

resource "aws_route_table_association" "db_subnet_to_nat_instance" {
  count          = local.nat_instance ? 1 : 0
  route_table_id = aws_route_table.nat_instance_db[count.index].id
  subnet_id      = aws_subnet.private_db.id
}