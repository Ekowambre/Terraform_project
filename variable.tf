variable "region" {
  description = "Deployment region for AWS infrastructure "
  type        = string
  default     = "eu-west-1"
}

variable "vpc_name" {
  description = "Placeholder name for VPC"
  type        = string
  default     = "Tenacity-VPC"
}

variable "vpc_tenancy" {
  description = "Tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "vpc_cidr" {
  description = "Cidr block of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_hostname_toggle" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "az-1" {
  description = "Availability zone for first public subnet"
  type        = string
  default     = "eu-west-1a"
}

variable "az-2" {
  description = "Availability zone for second public subnet"
  type        = string
  default     = "eu-west-1b"
}

variable "az-3" {
  description = "Availability zone for first private subnet"
  type        = string
  default     = "eu-west-1c"
}

variable "az-4" {
  description = "Availability zone for second private subnet"
  type        = string
  default     = "eu-west-1a"
}

variable "public_subnet_1_name" {
  description = "Tag to change Placeholder name of first public subnet"
  type        = string
  default     = "Prod-pub-sub1"
}

variable "public_subnet_2_name" {
  description = "Tag to change Placeholder name of second public subnet"
  type        = string
  default     = "Prod-pub-sub2"
}

variable "private_subnet_1_name" {
  description = "Tag to change Placeholder name of first private subnet"
  type        = string
  default     = "Prod-priv-sub1"
}

variable "private_subnet_2_name" {
  description = "Tag to change Placeholder name of second private subnet"
  type        = string
  default     = "Prod-priv-sub2"
}

variable "public_subnet_1_cidr" {
  description = "CIDR for first public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR for second public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR for first private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR for second private subnet"
  type        = string
  default     = "10.0.4.0/24"
}

variable "public_route_table" {
  description = "Tag to change Placeholder name of public route table"
  type        = string
  default     = "Prod-pub-route-table"
}

variable "private_route_table" {
  description = "Tag to change Placeholder name of private route table"
  type        = string
  default     = "Prod-priv-route-table"
}

variable "IGW" {
  description = "Tag to change Placeholder name of internet gateway"
  type        = string
  default     = "Prod-igw"
}

variable "IGW_cidr" {
  description = "CIDR for internet gateway destination"
  type        = string
  default     = "0.0.0.0/0"
}

variable "NGW_cidr" {
  description = "CIDR for NAT gateway destination"
  type        = string
  default     = "0.0.0.0/0"
}

variable "NGW" {
  description = "Tag to change Placeholder name of NAT gateway"
  type        = string
  default     = "Prod-Nat-gateway"
}

variable "flexible" {
  description = "Tag to show the type of environment"
  type        = string
  default     = "variable-environment"

}