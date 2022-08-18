output "ec2_public_ip" {
    description = "The public IP address of the EC2 instance."
    value = aws_instance.ec2_bastion_host.public_ip
}

output "vpc_id" {
    description = "ID of the VPC"
    value = aws_vpc.jazz_capstone.id
    sensitive = false
}

output "lb_address" {
    description = "loadbalancer address"
    value = aws_lb.jazz_alb.dns_name
  
}

output "rds_endpoint" {
    description = "rds_endpoint"
    value = aws_db_instance.jazz-mysql.address
    sensitive = false
}

output "web_app_instance" {
    description = "private ip"
    value = aws_instance.web_app.private_ip
  
}

# output "" {
#     description = "IP of load balancer"
#     value = aws_lb.jazz_alb.
#     sensitive = false
# }
