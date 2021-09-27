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
- When a VPC is created, a route table, NACL (Main) and a security group is created

### Subnet

- Subnet is a virtual firewall (public - internet accessible; private - accessible internally)
- 1 subnet is always in 1 AZ, and cannot span across multiple AZs
- Each subnet when created, allows 5 less IP Address than the possible range in CIDR block. AWS reserves first 4 and last 1 IP address in CIDR block
  - Example - 10.0.1.0/24 has 256 ip addresses available, but AWS lets use 251
    - 10.0.0.0 - Network Address
    - 10.0.0.1 - Reserved by AWS for VPC router
    - 10.0.0.2 - Reserved by AWS. IP Address of DNS server is the base path of VPC network range plus 2
    - 10.0.0.2 - Reserved by AWS for future use
    - 10.0.0.255 - Network broadcast address. Broadcast is not supported in VPC, that's why reserved
- Enabling Auto Assign public IPv4 address on subnet, will let all resources in this subnet to be accessible publicly

### Internet Gateway

- Default state after creation is `Detached`
- **Only one internet gateway can be attached per VPC**
- Internet Gateway can be attached to a VPC via console or CLI

  ```bash
  aws ec2 attach-internet-gateway --vpc-id "vpc-0d30873652e945f3e" --internet-gateway-id "igw-000f77855f757dc82" --region us-east-1
  ```


### Routing Table

- *The following subnets have not been explicitly associated with any route tables and are therefore associated with the main route table:* - When a subnet is created, it will always be on main routing table. Hence, we should not have route out to internet on main routing table, because all new subnets created will automatically be internet accessible - Not a good security practice
- Route out to internet - 0.0.0.0/0 and target as Internet Gateway

### NAT Gateways (Network Address Translation)

- NAT gateways can be used to enable instances in private subnets to connect to internet or other AWS services while preventing internet from initiating a connection with those instances
- Provisioned in a public subnet
- Facts
  - Redundant inside an availability zone
  - Starts at 5 Gbps and scales currently to 45 Gbps
  - No need to patch (AWS does it)
  - Not associated with security groups
  - Automatically assigned a public address
- Route out to internet is required (0.0.0.0/0) via Routing table outbound rule

## Exam Tips

- Consists of Internet Gateways (or private gateways), route tables, network access control list, subnets, and security groups
- NACLs (Network Access Control List) can be used to block certain IP addresses (not security groups)

### Samples

- cidr.xyz
