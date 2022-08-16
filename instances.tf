resource "aws_key_pair" "jazz" {
  key_name   = "jazz"
  public_key = file(var.ssh_public_key)

}






#* Bastion host
resource "aws_instance" "ec2_bastion_host" {
  ami                         = "ami-0ff89c4ce7de192ea"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.dmz_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.jazz_bastion_sec_grp.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jazz.key_name
  tags = {
    "Name" = "Jazz -EC2 Instance - Amazon Linux 2"
  }
}


#* Web app
resource "aws_instance" "ec2_bastion_host" {
  ami                         = "ami-0ff89c4ce7de192ea"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.front_end_private_subnet.id
  vpc_security_group_ids      = [aws_security_group]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jazz.key_name
  tags = {
    "Name" = "Jazz -EC2 Instance - Amazon Linux 2"
  }
}



#* RDS MYSQL
# resource "aws_db_instance" "default" {
#   allocated_storage    = 10
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   name                 = "mydb"
#   username             = "foo"
#   password             = "foobarbaz"
#   parameter_group_name = "default.mysql5.7"
#   skip_final_snapshot  = true
# }
