output "subnet_public_web" {
  value = aws_subnet.public_web.id
}

output "subnet_private_app" {
  value = aws_subnet.private_app.id
}

output "subnet_private_db" {
  value = aws_subnet.private_db.id
}

output "nat_gw_ip" {
  value = local.nat_gw ? join("", aws_eip.nat.*.public_ip) : ""
}

output "nat_instance_ip" {
  value = local.nat_instance ? join("", aws_instance.nat.*.public_ip) : ""
}

output "vpc_id" {
  value = aws_vpc.project.id
}

output "vpc_default_security_group" {
  value = aws_vpc.project.default_security_group_id
}

