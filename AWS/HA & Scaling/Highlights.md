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
- When creating a launch template for an Auto Scaling group and specifying a network interface, there are considerations and limitations that need to be taken into account in order to avoid errors.

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

### Scaling Policies (WHEN)

- [Step Scaling](./StepScaling.png)
  - [Scale Out or Scale In policies](./ScaleInScaleOut.png) based on conditions
  - Instance Warm-Up - Stops instances from being placed behind the load balancer, failing the health check and being terminated
  - Instance Cooldown - Pauses auto scaling for a set amount of time. Helps to avoid runaway scaling events (defaults to 5 minutes)
  - Avoids Thrashing - You want to create instances quickly and spin them down slowly
- Types
  - Reactive Scaling - Playing catchup, once load is there you measure it and then determine to if you need to create more resources
  - Scheduled Scaling - Great for predictive workload, create a scaling event to get resources ready to go before they are actually needed
  - Predictive Scaling - AWS uses ML to determine when scaling will be required. Reevaluated every 24 hours to create a forecast of next 48 hours
- **Steady state auto scaling group** - Min, Max and Desired set to 1 and multiple subnets, if an instance is terminated it will spin up a new one automatically in another AZs (subnet)

### Scaling Relational DBs (RDS)

- Scaling options
  - Vertical Scaling - Resizing the database from one size to another can create greater performance
  - Scaling Storage - Storage can be resized, but it only goes up not down
  - Read Replicas - Creating read-only copies to spread the workload across AZs and even regions (Upto 15 replicas with Aurora)
  - Aurora serverless - Scaling can be offloaded to AWS if using Aurora, as it excels on **unpredictable workloads**

### Scaling Non-Relational DBs (DynamoDB)

- Scaling is simplified as AWS does the heavy lifting
- Scaling options
  - Provisioned
    - Use case - Generally predictable workload
    - Effort to use - Need to review past usage to set upper and lower scaling bounds
    - Cost - Most cost-effective model
  - On-Demand
    - Use case - Sporadic workload
    - Effort to use - simply select on-demand
    - Cost - Pay small amount of money per read and write. Less cost effective
  - 24 hours of delay for switching from Provisioned mode to On-Demand mode

## Exam Tips

- [Launch Templates](./ExamTips-LaunchTemplates.png)
  - Easiest, AWS Recommended, more granularity, supports versioning. Favored solution over configurations
  - User data is included in template or configuration. If user data has to be changed, the versioning shall be done and new version shall be created for that launch template with updated user data
- Auto scaling
  - Auto scaling is important to build a highly available application - Sel answers that spread resources out over multiple AZs and utilize load balancers
  - Auto scaling groups will contain the location of where the instances will live
  - Its vital to select a load balancer for instances to live behind
  - Mix, Max and desired are the 3 most important settings
  - SNS can act as a notification tool
  - Will balance EC2 instances across the AZs
- Scaling Policies
  - Scale Out Aggressively - Get ahead of the workload
  - Scale In Conservatively - Slowly roll them back when not needed
  - Provisioning - Keep an eye on provisioning times, Bake more into the AMIs to minimize the time (the faster the load time is and faster warmup)
  - Costs - Use EC2 RIs (Reserved instances) for minimum count of EC2 instances
  - CloudWatch - Alerting Auto scaling
- Relational Database Scaling
  - Read Replicas - For read-heavy workload
  - Careful with Storage - RDS storage only scales up, not down
  - Vertical Scaling - Up-size the instance
  - Multi-AZ - Unless its dev env, turn this on for High availability
  - Aurora Everything - Whenever possible, use Aurora if the situation calls for relation DB
- Non-Relational Database Scaling
  - Access Patterns - Know if it is predictable or unpredictable
  - Design Matters - Avoiding similar keys to avoid hot partitions will also lead to better performance
  - Switching - Only allowed once per 24 hours per table
  - Cost - Predictable = Provisioned, Sporadic = On-Demand
- Is it highly available? - Default to think like this, unless question mentions. If question mentions, then we can expect failures of resources or slow performance of solution, mostly due to cost effectiveness
- Which is appropriate, vertical or horizontal - Generally favor Horizontal, but vertical is not left out
- Is is cost effective?
- Would switching databases fix the problem? - Hard in real life, easy to answer in AWS exam
- **Auto scaling can only be done for EC2** - Other services might have auto scaling, but they are not included in Auto scaling groups
- **Get ahead of workload** - Prefer to select solutions which are predictive rather than reactive
- **Bake AMIs to reduce build times** - To avoid long provisioning times, all data/services shall be put in AMIs. This is better than using user data if possible. Baking your code into your AMIs will help reduce provisioning time.
- **Spread out** - Spread out to multiple AZs/regions, its a requirement for a highly available system
- **Steady state groups** - Fits to a case where we cannot have more than 1 instance running/online of a legacy resource
- **ELBs are essential** - Make sure to enable health checks from load balancers, else the failed resources wont be terminated and replaced
- **RDS** has most amount of scaling options available
- Horizontal scaling is usually preferred over vertical
- Read replicas are friends
- DynamoDB scaling comes down to access patterns
- Auto Scaling groups live inside your VPC and do not span multiple regions
- When you use Elastic Load Balancing with your Auto Scaling group, it's not necessary to register individual EC2 instances with the load balancer. Instances that are launched by your Auto Scaling group are automatically registered with the load balancer. Likewise, instances that are terminated by your Auto Scaling group are automatically deregistered from the load balancer.

### Samples
