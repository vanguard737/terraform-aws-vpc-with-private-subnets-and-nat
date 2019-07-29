# allow internet access to Application nodes through NAT GW
resource "aws_route_table" "nat_gw" {
  count  = local.nat_gw ? 1 : 0
  vpc_id = aws_vpc.project.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = {
    Name = "APP/DB subnets to Internet through NAT gateway"
  }
}

resource "aws_route_table_association" "app_subnet_to_nat_gw" {
  count          = local.nat_gw ? 1 : 0
  route_table_id = aws_route_table.nat_gw[count.index].id
  subnet_id      = aws_subnet.private_app.id
}

resource "aws_route_table_association" "db_subnet_to_nat_gw" {
  count          = local.nat_gw ? 1 : 0
  route_table_id = aws_route_table.nat_gw[count.index].id
  subnet_id      = aws_subnet.private_db.id
}