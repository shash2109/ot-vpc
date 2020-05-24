variable "name" {
  description = "Name tag of the VPC"
  type        = string
  default     = "opstree"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "instance_tenancy" {
  description = "If this attribute is true, the provider ensures all EC2 instances that are launched in a VPC run on hardware that's dedicated to a single customer."
  type        = string
  default     = "default"
}

variable "enable_dns_support" {
  description = "If this attribute is false, the Amazon-provided DNS server that resolves public DNS hostnames to IP addresses is not enabled."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "If this attribute is true, instances in the VPC get public DNS hostnames, but only if the enableDnsSupport attribute is also set to true."
  type        = bool
  default     = false
}

variable "enable_classiclink" {
  description = "If this attribute is true, ClassicLink allows you to link EC2-Classic instances to a VPC in your account, within the same region."
  type        = bool
  default     = false
}

variable "enable_classiclink_dns_support" {
  description = "If this attribute is true, the DNS hostname of a linked EC2-Classic instance resolves to its private IP address when addressed from an instance in the VPC to which it's linked."
  type        = bool
  default     = false
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}
