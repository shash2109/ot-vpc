output "ngw_id1" {
  description = "The id of the NGW attached to VPC"
  value       = aws_nat_gateway.nat_gw1.id
}

output "nat_ip1" {
  description = "The public ip for the NGW attached to VPC"
  value       = aws_eip.nat_ip1.public_ip
}