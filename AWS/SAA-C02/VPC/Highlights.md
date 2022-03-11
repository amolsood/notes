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
- VPC belongs only to one region. You can have more than one VPC per region. However, there is a soft limit of 5 VPCs per region. You can ask Amazon for more than 5 if you need.

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
- AZ can have more than one subnets. However, there is a soft limit of 200 subnets per AZ. You can ask Amazon for more than 200 if you need.

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
- NAT Gateways are charged on an hourly basis even for idle time.

### Security Groups and Network ACLs (NACL)

- Security groups are virtual firewalls for an EC2 instance, defaults to `blocked` unless opened to 0.0.0.0/0 (to open up to everything)
- Are stateful in nature. **Responses to allowed inbound traffic are allowed flow out irrespective of outbound rules**. If port 80 is opened as inbound rule and blocked in outbound rule, it will still allow the communication over port 80.
- NACL is an optional layer of security which acts as a firewall for a VPC which monitors traffic flowing in or out.
- Inbound and outbound traffic is
  - allowed for Default NACLs
  - blocked by default on Custom NACLs until rules are added
- Each subnet in VPC must be associated an NACL. If not explicitly specified, it will associate to default NACL
- **Block IP Addresses using NACL, not security groups**
- An NACL can be associated to multiple subnets, but a subnet can associate to one NACL at a time
- NACL contain a numbered list of rules, and executed as per the order starting from lowest number. Allow rule before deny rule will allow the traffic.
- NACLs have separate inbound and outbound rules and each rule either allow or deny the traffic
- Network ACLs are stateless as responses to allowed inbound traffic are subject to outbound rules and vice-versa
- Ephemeral Ports shall be opened to cover different types of clients that might initiate traffic to public facing instances. (1024-65535). This to allow clients to communicate and temporarily allow a session, which receives request on port 80 but respond via random port
- No ip addresses and ports are left open by default to a security group
- NACLs are located at the subnet level
- The default network ACL is configured to allow all traffic to flow in and out of the subnets with which it is associated. Each network ACL also includes a rule whose rule number is an asterisk. This rule ensures that if a packet doesn't match any of the other numbered rules, it's denied. You can't modify or remove this rule

## VPC Endpoints

- Enables allow to connect privately to your VPC for supported AWS services using AWS PrivateLink without requiring an Internet Gateway, NAT, VPN, AWS Direct Connect connections, etc
- Are virtual devices and are horizontally scaled, redundant and highly available VPC components that allow communication between instances in your VPC and services without imposing availability risks or bandwidth constraints on network traffic.
- Types
  1. Interface Endpoints - An Elastic Network Interface with a private IP Address that serves as an entry point for traffic headed to a supported service. Support large number of AWS services
  2. Gateway Endpoints - Similar to NAT Gateways, a gateway endpoint is a virtual device. It support connection to S3 and DynamoDB
- Use case - When you want to use AWS services without leaving AWS internal network

### AWS PrivateLink

- Allows the VPCs to share applications, without opening upto internet and VPC peering, no route tables, NAT gateways, internet gateways.
- PrivateLink allows you to share out a single endpoint and not your entire VPC
- Best to way to connect to other tens, hundreds, thousands of VPCs
- The service VPC has to have a Network Load balancer and client VPC has to have an ENI to connect via PrivateLink

### VPC Peering

- Allows a VPC to connect to another VPC via direct network route using private IP addresses.
- Instances behave like they were on same private network.
- VPCs can be peered with other VPCs in another AWS account, as well with other VPCs in same account.
- Peering is in star configuration, (e.g 1 central VPC peers with 4 others), no [transitive peering](./Transitive%20Peering.png) and does not work on Hub-and-Spoke model
- Can peer between regions.
- **Same CIDR address ranged VPCs cannot be peered, Overlapping CIDR address ranged VPCs cannot be peered**
- The VPCs can be in different regions (also known as an inter-region VPC peering connection)
- AWS uses the existing infrastructure of a VPC to create a VPC peering connection; it is neither a gateway nor a VPN connection, and does not rely on a separate piece of physical hardware. There is no single point of failure for communication or a bandwidth bottleneck.
- This allows VPC resources including EC2 instances, Amazon RDS databases and Lambda functions that run in different AWS Regions to communicate with each other using private IP addresses, without requiring gateways, VPN connections, or separate network appliances

### [AWS VPN CloudHub](./AWS%20VPN%20CloudHub.png)

- If you have multiple sites, each with their own VPN connection, then AWS CloudHub can be used to connect sites together
- Similar to VPC Peering but works on Hub-and-Spoke model
- Low cost and easy to manage
- Operates over public internet but all traffic between customer gateway and AWS VPN CloudHub is encrypted

### [AWS DirectConnect](./DirectConnect.png)

- It is a service that lets to establish a dedicated network connection from your premises on AWS
- Consistent network connection
- Types
  - Dedicated Connection - A physical ethernet connection associated with a single customer. Can request a connection, via AWS DirectConnect Console, CLI or API
  - Hosted Connection - A physical ethernet connection, that an AWS Direct Connect partner provisions on a behalf of customer. Customer request a hosted connection by a contacting a partner in AWS Direct Connect Partner program who provisions the connection
- DirectConnect is faster, secure, reliable, and able to take massive throughput than VPN (a private connection which still routes the via public internet and slow)
- Connects data center directly to AWS network
- Useful for high-throughput workloads
- Helpful when a stable and reliable connection is needed
- Scenario - VPN keeps dropping out, and stable, secure and low cost connection is required
- DirectConnect connection is not encrypted by default

### Transit Gateway

- Connects VPCs and on-premise networks through a [central hub](./SampleComplexNetworkUsingTransitGateway.png) and solves [complexity](./SampleComplexNetwork.png) in connections and peering.
- It acts as cloud router, each new connection is only made once
- Facts
  - Allows to transitive peering between thousands of VPCs and on-premise data centers
  - Works on Hub-and-spoke model
  - Works on regional basis but can have across multiple regions
  - Works across multiple AWS accounts using Resource Access Manager (RAM)
  - Works with Direct Connect and VPN connections
  - **Supports IP multicast (not supported by any other AWS service)**
- Scenario - Simplifying network topology or IP multi-casting

## Exam Tips

- Logical Data center in AWS
- Consists of Internet Gateways (or private gateways), route tables, network access control list, subnets, and security groups
- 1 subnet is always in 1 AZ
- NACLs (Network Access Control List) can be used to block certain IP addresses (not security groups)
- NAT Gateways are redundant inside the AZ
- NAT Gateways are auto-scalable and starts at 5Gbps and scales currently to 45Gbps
- NAT Gateways is not required to be patched (OS)
- NAT Gateways is not associated with any security group
- NAT Gateways is assigned a public address automatically
- [NAT Gateways - Scenario](./Tip%20-%20NAT%20Gateways.png)
- Security groups are stateful
- NACLs are stateless
- Default NACL allows inbound/outbound traffic by default
- Custom NACL denies inbound/outbound traffic by default, and rules are evaluated by lowest rule number first
- Each subnet must be associated with at-least 1 NACL. If not associated explicitly, it is associated to default NACL automatically
- Block IP Addresses using NACLs not security groups
- NACL can be associated to multiple subnets, but a subnet can only be associated to only 1 NACL
- NACLs are located at the subnet level
- The default network ACL is configured to allow all traffic to flow in and out of the subnets with which it is associated. Each network ACL also includes a rule whose rule number is an asterisk. This rule ensures that if a packet doesn't match any of the other numbered rules, it's denied. You can't modify or remove this rule
- You can't have a VPC with IPv6 CIDRs only. The default IP addressing system in VPC is IPv4. You can only change your VPC to dual-stack mode where your resources can communicate over IPv4, or IPv6, or both, but not exclusively with IPv6 only.
- To enable the connection to a service running on an instance, the associated network ACL must allow both inbound traffic on the port that the service is listening on as well as allow outbound traffic from ephemeral ports. When a client connects to a server, a random port from the ephemeral port range (1024-65535) becomes the client's source port.

### Samples

- cidr.xyz
