# VPC

## Points

- Logically isolated part of AWS Cloud where you can define your own network
- Complete control on all resources of network and fully customizable
- Default VPCs
  - User friendly
  - All subnets in default VPC have a route out to internet
  - Each EC2 instance in this VPC has a public and a private IP Address
- Custom VPCs
  - Fully customizable
  - Takes time to setup
- When a VPC is created, a route table, NACL and a security group is created

### Subnet

- Subnet is a virtual firewall
- 1 subnet is always in 1 AZ, and cannot span across multiple AZs
- Each subnet when created, allows 5 less IP Address than the possible range in CIDR block. AWS reserves first 4 and last 1 IP address in CIDR block
  - Example - 10.0.1.0/24 has 256 ip addresses available, but AWS lets use 251
    - 10.0.0.0 - Network Address
    - 10.0.0.1 - Reserved by AWS for VPC router
    - 10.0.0.2 - Reserved by AWS. IP Address of DNS server is the base path of VPC network range plus 2
    - 10.0.0.2 - Reserved by AWS for future use
    - 10.0.0.255 - Network broadcast address. Broadcast is not supported in VPC, that's why reserved

## Exam Tips

- Consists of Internet Gateways (or private gateways), route tables, network access control list, subnets, and security groups
- NACLs (Network Access Control List) can be used to block certain IP addresses (not security groups)

### Samples

- cidr.xyz
