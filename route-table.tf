#* ROUTE TABLE NAME

#? ROUTE TABLE DMZ
resource "aws_route_table" "dmz_route_table" {
  vpc_id = aws_vpc.jazz_capstone.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dmz_igw.id
  }
  tags = {
    "Name" = var.dmz_route_table_name
  }
}

#? ROUTE TABLE FRONTEND
resource "aws_route_table" "frontend_route_table" {
  vpc_id = aws_vpc.jazz_capstone.id

  tags = {
    "Name" = var.frontend_route_table_name
  }
}

#? ROUTE TABLE BACKEND
resource "aws_route_table" "backend_route_table" {
  vpc_id = aws_vpc.jazz_capstone.id

  tags = {
    "Name" = var.backend_route_table_name
  }
}



#* ROUTE TABLE ASSOCIATION

#? DMZ ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "dmz_route_table_association" {
  subnet_id      = aws_subnet.dmz_public_subnet.id
  route_table_id = aws_route_table.dmz_route_table.id
}

#? FRONTEND ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "frontend_route_table_association" {
  subnet_id      = aws_subnet.front_end_private_subnet.id
  route_table_id = aws_route_table.frontend_route_table.id
}

#? BACKEND ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "backend_route_table_association" {
  subnet_id      = aws_subnet.back_end_private_subnet.id
  route_table_id = aws_route_table.backend_route_table.id
}
