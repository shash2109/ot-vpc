variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "name" {
  description = "Name of the VPC to be created"
  type        = string
}

variable "tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "public_subnets_cidr" {
  description = "CIDR list for public subnet"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "CIDR list for private subnet"
  type        = list(string)
}

variable "avaialability_zones" {
  description = "List of avaialability zones"
  type        = list(string)
}

variable "logs_bucket" {
  description = "Name of bucket where we would be storing our logs"
}

variable "pvt_zone_name" {
  description = "Name of private zone"
  type = string
}

variable "enable_dns_support" {
  type = bool
  default = true
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}

variable "instance_tenancy" {
  type = string
  default = "default"
}

variable "log_destination_type" {
  type = string
  default = "s3"
}

variable "traffic_type" {
  type = string
  default = "ALL"
}

variable "enable_vpc_logs" {
  type = bool
  default = true
}

variable "enable_alb_logging" {
  type = bool
  default = true
}

variable "enable_deletion_protection" {
  type = bool
  default = true
}