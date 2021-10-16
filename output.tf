output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "pub_route_table_id" {
  description = "Public route table ID"
  value = module.publicRouteTable.id
}

output "pvt_route_table_id_aza" {
  description = "Private Route table ID for aza" 
  value = module.privateRouteTable_aza.id
}

output "pvt_route_table_id_azb" {
  description = "Private Route table ID for azb" 
  value = module.privateRouteTable_azb.id
}

output "pvt_route_table_id_azc" {
  description = "Private Route table ID for azc" 
  value = module.privateRouteTable_azc.id
}

output "pub_alb_dns" {
  value = module.pub_alb.dns_name
}

output "pvt_hosted_zone_id" {
  description = "hosted zone id"
  value       = aws_route53_zone.private_hosted_zone.zone_id
}

output "security_group_id" {
  description = "security group id"
  value = module.public_web_security_group.sg_id
}
