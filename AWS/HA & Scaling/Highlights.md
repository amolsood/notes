# High Availability (HA) and Scaling

## Points

- Vertical Scaling - Increasing resource size (resize existing resources). t2.micro to t2.large
- Horizontal Scaling - Increasing resource count (adding more instances to existing farm). Helps in HA
- 3Ws
  - WHAT - what do we scale? - What sort of resource needs scaling
  - WHERE - where do we scale? - Where do we scale, databases, web servers etc
  - WHEN - when do we scale? - When does it makes sense to scale, or when more resources are required. CloudWatch alarms can help
- [Template vs Configuration](./TemplatesVSConfiguration.png)

### Vertical Scaling

- Increasing resources (resize existing resources)

### Launch Templates (EC2) (WHAT)

- Specifies all the settings needed those are required to build an EC2 instance for example
- It is collection of settings which can be configured so that we don't need walk through the same wizard over and over
- Easiest, AWS Recommended, more granularity, supports versioning. Favored solution over configurations
- User data is included in template or configuration. If user data has to be changed, the versioning shall be done and new version shall be created for that launch template with updated user data

### Auto scaling group (WHERE)

- Auto scaling group contains a collection of EC2 instances that are treated as a collective group for purposes of scaling and management
- [Steps](./AutoScaling.png)
  - Define the template - Pick the template to choose for EC2 instances to be hosted
  - Networking and purchasing - Pick networking space and purchasing options. Use multiple AZs for High availability
  - ELB configuration - EC2 instances can be registered behind a load balancer. It can do the health checks on load balancer, and automatically deregister the target group and spin another one
  - Set scaling policies - Set the minimum and maximum scaling required to ensure the right number of resources
  - Notifications - SNS can be used to notify if there is an event of scaling
- Restrictions
  - Minimum - This is the lowest of number of EC2 instances which will be online, it won't down scale below this threshold. If set to 0, it can shutdown the last one EC2 instance running if not in use
  - Maximum - The roof, it won't up scale above this threshold. Cost to be considered
  - Desired - How many are required at current point in time

## Exam Tips

- [Launch Templates](./ExamTips-LaunchTemplates.png)
  - Easiest, AWS Recommended, more granularity, supports versioning. Favored solution over configurations
  - User data is included in template or configuration. If user data has to be changed, the versioning shall be done and new version shall be created for that launch template with updated user data

### Samples
