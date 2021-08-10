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

## Exam Tips

- Like a VM, hosted in AWS, grow and shrink capacity
- On-demand, reserved, spot, dedicated hosts

### Samples

- Connect via SSH
  - Format - ssh -i "{KeyPair.pem}" {username}@ec2-{0-0-0-0(public_ip)}.compute-1.amazonaws.com
  - Example - ssh -i "TestKeyPair.pem" ec2-user@ec2-52-91-123-10.compute-1.amazonaws.com
