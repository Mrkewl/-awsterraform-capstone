#* ELASTIC IP   

resource "aws_eip" "nat_elastic_ip" {
  vpc = true
  tags = {
    "Name" = var.elastic_ip_name
  }
}


#* INTERNET GATEWAY FOR PUBLIC SUBNET
resource "aws_internet_gateway" "dmz_igw" {
  vpc_id = aws_vpc.jazz_capstone.id
  tags = {
    "NAME" = var.dmz_igw_name
  }
}
#* Network Address Translation
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.dmz_public_subnet.id
  depends_on = [
    aws_eip.nat_elastic_ip,
    aws_internet_gateway.dmz_igw
  ]
}

