resource "aws_key_pair" "jazz" {
  key_name   = "jazz"
  public_key = file(var.ssh_public_key)

}






#* Bastion host
resource "aws_instance" "ec2_bastion_host" {
  ami                         = "ami-090fa75af13c156b4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.dmz_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.jazz_bastion_sec_grp.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jazz.key_name
  user_data                   = file("./web-app-entrypoint.sh")
  tags = {
    "Name" = "Jazz-bastion-host"
  }
}




#* Web app
resource "aws_instance" "web_app" {
  ami                         = "ami-090fa75af13c156b4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.front_end_private_subnet.id
  vpc_security_group_ids      = [aws_security_group.frontend_private_sec_grp.id]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.jazz.key_name
  user_data                   = file("./web-app-entrypoint-2.sh")
  tags = {
    "Name" = "Jazz-web-app"
  }
}





#* RDS MYSQL
resource "aws_db_subnet_group" "Jazz_subnet_group_1" {
  subnet_ids = [aws_subnet.front_end_private_subnet.id, aws_subnet.back_end_private_subnet.id]

  description = "Subnet for Database instance"
  tags = {
    Name = "Jazz Database Subnets"
  }
}



resource "aws_db_instance" "jazz-mysql" {
  db_subnet_group_name   = aws_db_subnet_group.Jazz_subnet_group_1.id
  vpc_security_group_ids = [aws_security_group.backend_sec_grp.id]
  multi_az               = false
  allocated_storage      = 20
  identifier             = "jazz-mysqldb"
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "admin123."
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
}
