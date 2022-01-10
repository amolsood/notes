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

### Security Groups and Network ACLs (NACL)

- Security groups are virtual firewalls for and EC2 instance, defaults to `blocked` unless opened to 0.0.0.0/0 (to open up to everything)
- Are stateful in nature. **Responses to allowed inbound traffic are allowed flow out irrespective of outbound rules**. If port 80 is opened as inbound rule and blocked in outbound rule, it will still allow the communication over port 80.
- NACL is an optional layer of security which acts as a firewall for a VPC which monitors traffic flowing in or out.
- Inbound and outboud traffic is
  - allowed for Default NACLs
  - blocked by default on Custom NACLs until rules are added
- Each subnet in VPC must be associated an NACL. If not explicitly specified, it will associate to default NACL
- **Block IP Addresses using NACL, not security groups**
- An NACL can be associated to multiple subnets, but a subnet can associate to one NACL at a time
- NACL contain a numbered list of rules, and executed as per the order starting from lowest number. Allow rule before deny rule will allow the traffic.
- NACLs have separate inbound and outbound rules and each rule either allow or deny the traffic
- Network ACLs are stateless as responses to allowed inbound traffic are subject to outbound rules and vice-versa
- Ephemeral Ports shall be opened to cover different types of clients that might initiate traffic to public facing instances. (1024-65535). This to allow clients to communicate and temporarily allow a session, which receives request on port 80 but respond via random port

## VPC Endpoints

- Enables allow to connect privately to your VPC for supported AWS services using AWS PrivateLink without requiring an Internet Gateway, NAT, VPN, AWS Direct Connect connections, etc
- Are virtual devices and are horizontally scaled, redundant and highly available VPC components that allow communication between instances in your VPC and services without imposing availability risks or bandwidth constraints on network traffic.
- Types
  1. Interface Endpoints - An Elastic Network Interface with a private IP Address that serves as an entry point for traffic headed to a supported service. Support large number of AWS services
  2. Gateway Endpoints - Similar to NAT Gateways, a gateway endpoint is a virtual device. It support connection to S3 and DynamoDB
- Use case - When you want to use AWS services without leaving AWS internal network

### AWS PrivateLink

- Allows the VPCs to share applications, without opening upto internet and VPC peering, no route tables, NAT gateways, internet gateways.
- Best to way to connect to other tens, hundreds, thousands of VPCs
- The service VPC has to have a Network Load balancer and client VPC has to have an ENI to connect via PrivateLink

### VPC Peering

- Allows a VPC to connect to another VPC via direct network route using private IP addresses.
- Instances behave like they were on same private network.
- VPCs can be peered with other VPCs in another AWS account, as well with other VPCs in same account.
- Peering is in star configuration, (e.g 1 central VPC peers with 4 others), no transitive peering and does not work on Hub-and-Spoke model
- Can peer between regions.
- **Same CIDR address ranged VPCs cannot be peered, Overlapping CIDR address ranged VPCs cannot be peered**

### AWS VPN CloudHub

- If you have multiple sites, each with their own VPN connection, then AWS CloudHub can be used to connect sites together
- Similar to VPC Peering but works on Hub-and-Spoke model
- Low cost and easy to manage
- Operates over public internet but all traffic between customer gateway and AWS VPN CloudHub is encrypted

## Exam Tips

- Consists of Internet Gateways (or private gateways), route tables, network access control list, subnets, and security groups
- NACLs (Network Access Control List) can be used to block certain IP addresses (not security groups)

### Samples

- cidr.xyz
