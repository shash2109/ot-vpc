output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "pvt_route_table_id" {
  description = "Private Route table ID" 
  value = module.privateRouteTable.id
}

output "pub_alb_dns" {
  value = module.pub_alb.dns_name
}

output "pvt_hosted_zone_id" {
  description = "hosted zone id"
  value       = aws_route53_zone.private_hosted_zone.zone_id
}

