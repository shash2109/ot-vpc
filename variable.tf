variable "subnets_for_nat_gw" {
  type = list(string)
}

variable "vpc_name" {
  description = "Name of VPC in which NAT will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "route_table_id" {
    description = "private route table id"
    type = string
}

variable "vpc_id" {
    type = string
}