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
