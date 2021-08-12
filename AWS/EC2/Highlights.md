# EC2

## Points

- Pricing Options
  - On-Demand - Pay by hour
  - Reserved - Reserved Capacity for 1 to 3 years, upto 72% discount on hourly charge
  - Spot - Purchase unused capacity at upto 90% discount, Prices fluctuate with supply and demand
  - Dedicated - A more expensive physical server dedicated for your use

### Pricing Options

- On Demand
  - Low Cost and flexible without upfront payment
  - For Short term, spiky and unpredictable workloads
  - Testing of applications
- Reserved
  - Used for predictable usage
  - Specific capacity requirements
  - Pay up front to reduce the total computing costs
  - Standard Reserved Instance (RIs) - Upto 72% discount on on-demand
  - Convertible RIs - Upto 54% discount on on-demand
  - Scheduled RIs - Capacity reservation (high/low) in specific time window. For predictable recurring schedule that only requires a fraction of a day, week, month etc
  - Operate at Regional Level (**Region Specific**)
- Spot
  - Moves like share price, once the capacity is available for desired price, the spot instance is available, once the price moves away, spot instance is terminated
  - Used for applications which have flexible start and end times (not web servers)
  - Applications which are feasible at low compute prices
  - Users with an urgent need of additional or high compute capacity
- Dedicated Hosts
  - For compliance - Regulatory requirements that my not support multi-tenant virtualization
  - Licensing - Great for licensing which does not support multi-tenancy or cloud deployments
  - Can be purchased on demand
  - Can also be purchased as Reserved for upto 70% discount on on-demand

### Security Groups

- Virtual firewall for EC2 instances
- Default access is restricted (blocked)
- To let everything in: 0.0.0.0/0
- For outside communication, open correct ports over HTTP/HTTPS/RDP/SSH
- RDP and SSH not recommended due to possibility of Brute Force attack
- Any number of instances can be launched in a security group
- All inbound traffic is blocked by default
- All outbound traffic is allowed
- Multiple Security groups can be attached to an EC2 instance

### BootStrap Scripts

- Allows to run commands on EC2 instance boot
- Increases boot time based on commands
- Helps to automate installation of certain packages/applications
- Changes to security group takes effect immediately
- It passes user data to EC2 instance at boot time

## Exam Tips

- Like a VM, hosted in AWS, grow and shrink capacity
- On-demand, reserved, spot, dedicated hosts
- Roles are preferred via EC2 rather than coded credentials from security perspective
- Avoid hard coding aws credentials in EC2, use roles instead
- Policies control a role's permissions
- Any policy updates to the role take immediate effect
- Roles can be attached or detached at EC2 runtime with immediate effect without stopping or terminate the instance

### Samples

- Connect via SSH
  - Format - ssh -i "{KeyPair.pem}" {username}@ec2-{0-0-0-0(public_ip)}.compute-1.amazonaws.com
  - Example - ssh -i "TestKeyPair.pem" ec2-user@ec2-52-91-123-10.compute-1.amazonaws.com
