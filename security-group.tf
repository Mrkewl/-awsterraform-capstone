#! AWS SECURITY GRP
resource "aws_security_group" "jazz_bastion_sec_grp" {
  vpc_id = aws_vpc.jazz_capstone.id
  name   = "bastion-sec-grp"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Jazz-bastion-Security-Group"

  }

}

resource "aws_security_group" "frontend_private_sec_grp" {
  vpc_id = aws_vpc.jazz_capstone.id
  name   = "frontend-sec-grp"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.jazz_bastion_sec_grp.id]
    # cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }
    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }
      ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Jazz-frontend-Security-Group"

  }

}

resource "aws_security_group" "backend_sec_grp" {


  vpc_id = aws_vpc.jazz_capstone.id
  name   = "backend-sec-grp"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.frontend_private_sec_grp.id]
    # cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = [var.my_public_ip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Jazz-backend-Security-Group"

  }

}


resource "aws_security_group" "jazz_elastic_lb_sec_grp" {
  vpc_id = aws_vpc.jazz_capstone.id
  name   = "jazz"

    ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS access for ALB"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Listen on port 8080"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Jazz-Security-Group"

  }

}


