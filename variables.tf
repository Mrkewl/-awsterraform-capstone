#* AWS CONFIG
variable "access_key" {}
variable "secret_key" {}
variable "region" {}

#* AWS VPC
variable "main_vpc_name" {}
variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "CIDR block for the vpc"
  type        = string
}

#* AWS SUBNETS
variable "dmz_public_subnet_availability_zone" {}
variable "frontend_public_subnet_availability_zone" {}
variable "backend_public_subnet_availability_zone" {}
variable "dmz_public_subnet_name" {}
variable "frontend_private_subnet_name" {}
variable "backend_private_subnet_name" {}
variable "dmz_public_subnet" {
  default     = "10.0.10.0/24"
  description = "DMZ Public subnet"
  type        = string

}
variable "frontend_private_subnet" {
  default     = "10.0.20.0/24"
  description = "Front-end Private subnet"
  type        = string

}
variable "backend_private_subnet" {
  default     = "10.0.30.0/24"
  description = "Back-end private subnet"
  type        = string

}

#* AWS GATEWAYS
variable "dmz_igw_name" {}

#* AWS ROUTE TABLE
variable "dmz_route_table_name" {}
variable "frontend_route_table_name" {}
variable "backend_route_table_name" {}