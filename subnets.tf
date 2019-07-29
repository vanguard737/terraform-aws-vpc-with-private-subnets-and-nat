/*
Subnet calculator:
  http://www.davidc.net/sites/default/subnets/subnets.html
In the event of future growth, like adding failover to us-west-2c, these subnets are still available in this VPC:
WEB:  10.100.128.0/18; IPs:  10.100.128.1 - 10.100.191.254; hosts: 16382
APP:  10.100.192.0/19; IPs:  10.100.192.1 - 10.100.223.254; hosts: 8190
DB:   10.100.224.0/19; IPs:  10.100.224.1 - 10.100.255.254; hosts: 8190
*/

# public subnet - web
# Hosts:  16382
# Usable IPs:  10.100.0.1 - 10.100.63.254
resource "aws_subnet" "public_web" {
  cidr_block        = "10.100.0.0/18"
  vpc_id            = aws_vpc.project.id
  availability_zone = "us-west-2b"

  tags = {
    Name       = "WEB-1"
    Visibility = "Public"
  }
}


# private subnet - app
# Hosts:  8190
# Usable IPs:  10.100.64.1 - 10.100.95.254
resource "aws_subnet" "private_app" {
  cidr_block        = "10.100.64.0/19"
  vpc_id            = aws_vpc.project.id
  availability_zone = "us-west-2b"

  tags = {
    Name       = "APP-1"
    Visibility = "Private"
  }
}

# private subnet - db
# Hosts:  8190
# Usable IPs:  10.100.96.1 - 10.100.127.254
resource "aws_subnet" "private_db" {
  cidr_block        = "10.100.96.0/19"
  vpc_id            = aws_vpc.project.id
  availability_zone = "us-west-2b"

  tags = {
    Name       = "DB-1"
    Visibility = "Private"
  }
}


