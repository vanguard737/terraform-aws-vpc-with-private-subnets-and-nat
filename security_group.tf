resource "aws_security_group" "access_via_nat" {
  count       = local.nat_instance ? 1 : 0
  name        = "Access to NAT instance"
  description = "Access to Internet via NAT instance for private nodes"
  vpc_id      = aws_vpc.project.id

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_inbound_traffic_app" {
  count             = local.nat_instance ? 1 : 0
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = [aws_subnet.private_app.cidr_block]
  security_group_id = aws_security_group.access_via_nat[count.index].id
}

resource "aws_security_group_rule" "allow_inbound_traffic_db" {
  count             = local.nat_instance ? 1 : 0
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = [aws_subnet.private_db.cidr_block]
  security_group_id = aws_security_group.access_via_nat[count.index].id
}