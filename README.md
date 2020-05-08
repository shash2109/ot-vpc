AWS Network Skeleton Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates network skeleton on AWS.

These types of resources are supported:

* [VPC](https://www.terraform.io/docs/providers/aws/r/vpc.html)

Terraform versions
------------------

Terraform 0.12.

Usage
------

```hcl
provider "aws" {
  region                  = "ap-south-1"
}

module "vpc" {
  source = "../"

  name = "opstree"
  cidr_block = "10.0.0.0/24"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = false
  enable_classiclink = false

  vpc_tags = {
    key1 = "value1"
    key2 = "value2"
  }  
}

```

```
output "vpc_id" {
  value       = module.network_skeleton.vpc_id
}

output "vpc_arn" {
  value       = module.network_skeleton.arn
}

```
Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The sting name append in tags | `string` | `"opstree"` | yes |
| cidr_block | The CIDR block for the VPC. Default value is a valid CIDR  | `string` | `"10.0.0.0/24"` | no |
| instance_tenancy | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| enable_dns_support | A dns support for instances launched into the VPC | `boolean` | `"true"` | no |
| enable_dns_hostnames | A dns hostname for instances launched into the VPC | `boolean` | `"false"` | no |
| enable_classiclink |A dns classiclink for instances launched into the VPC | `boolean` | `"false"` | no |

Output
------
| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| arn | The arn of the VPC |

## Related Projects

Check out these related projects.

- [security_group](https://github.com/OT-CLOUD-KIT/terraform-aws-network-skeleton) - Terraform module for creating dynamic Security 

### Contributors

|  [![Sudipt Sharma][sudipt_avatar]][sudipt_homepage]<br/>[Sudipt Sharma][sudipt_homepage] | [![Devesh Sharma][devesh_avataar]][devesh_homepage]<br/>[Devesh Sharma][devesh_homepage] |
|---|---|

  [sudipt_homepage]: https://github.com/iamsudipt
  [sudipt_avatar]: https://img.cloudposse.com/75x75/https://github.com/iamsudipt.png
  [devesh_homepage]: https://github.com/deveshs23
  [devesh_avataar]: https://img.cloudposse.com/75x75/https://github.com/deveshs23.png