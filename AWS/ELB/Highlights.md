# ELB (Elastic Load Balancer)

## Points

- Automatically distributes incoming application traffic across multiple targets, such as Amazon EC2 instances
- Load balancing can be done across multiple AZs
- Types
  - Application Load Balancer - Best suited for balancing HTTP and HTTPS traffic. Operate at layer-7 and are application-aware (Intelligent Load Balancer)
  - Network Load Balancer - Operates on connection level (layer-4), capable of handling millions of requests per seconds while maintaining ultra-low latencies (Performance Load Balancer)
  - Classic Load Balancer - Legacy load balancers. Can load balance HTTP/HTTPS application and use layer-7 specific features, such as X-forwarded and sticky sessions (Classis/Test/Dev Load Balancer)

### Health Checks

- All load balancers can be setup with Health checks
- Sends requests periodically to test their status as healthy or unhealthy
- Status of instances that are unhealthy at the time of check is **OutOfService**
- Load balancers send requests to only healthy instances. When and instance is unhealthy, it stops routing requests to that instance. It will resume the routing to instance as soon as it becomes healthy again

### Application Load Balancers

- Layer 7 load balancing - Functions at Application layer of OSI model
- Listeners - Checks for connection requests from clients, using protocol and ports configured. Rules are defined to instruct load balancer to route the requests to registered targets. Each rule has a priority, one or more actions, one or more conditions
- Rules - If rules are met, the its actions are performed. Each listener should have a default rule defined
- Target Groups - Each target group routes requests to one or more registered targets, such as EC2 instances
- Limitations - Only supports HTTP/HTTPS
- HTTPS - To use HTTPS load balancer, you should deploy at least one SSL/TLS server certificate on load balancer. The load balancer uses a server certificate to terminate the frontend connection and then decrypt requests from clients before sending them to the targets

### Network Load Balancers

## Exam Tips

### Samples
