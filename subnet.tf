resource "aws_subnet" "dmz_public_subnet" {
  vpc_id                  = aws_vpc.jazz_capstone.id
  cidr_block              = var.dmz_public_subnet
  map_public_ip_on_launch = true
  tags = {
    "Name" = var.dmz_public_subnet_name
  }

}
resource "aws_subnet" "front_end_private_subnet" {
  vpc_id                  = aws_vpc.jazz_capstone.id
  cidr_block              = var.frontend_private_subnet
  map_public_ip_on_launch = false

  tags = {
    "Name" = var.frontend_private_subnet_name
  }
}
resource "aws_subnet" "back_end_private_subnet" {
  vpc_id                  = aws_vpc.jazz_capstone.id
  cidr_block              = var.backend_private_subnet
  map_public_ip_on_launch = false

  tags = {
    "Name" = var.backend_private_subnet_name
  }
}
