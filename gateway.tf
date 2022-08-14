#* INTERNET GATEWAY FOR PUBLIC SUBNET
resource "aws_internet_gateway" "dmz_igw" {
  vpc_id = aws_vpc.jazz_capstone
  tags = {
    "NAME" = var.dmz_igw_name
  }
}

resource "aws_nat_gateway" "front_end_nat" {
  
}
resource "aws_nat_gateway" "back_end_nat" {
  
}