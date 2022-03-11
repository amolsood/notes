# ELB (Elastic Load Balancer)

## Points

- Automatically distributes incoming application traffic across multiple targets, such as Amazon EC2 instances
- Load balancing can be done across multiple AZs
- Types
  - Application Load Balancer - Best suited for balancing HTTP and HTTPS traffic. Operate at layer-7 and are application-aware (Intelligent Load Balancer)
  - Network Load Balancer - Operates on connection level (layer-4), capable of handling millions of requests per seconds while maintaining ultra-low latencies (Performance Load Balancer)
  - Classic Load Balancer - Legacy load balancers. Can load balance HTTP/HTTPS application and use layer-7 specific features, such as X-forwarded and sticky sessions (Classic/Test/Dev Load Balancer)

### Health Checks

- All load balancers can be setup with Health checks
- Sends requests periodically to test their status as healthy or unhealthy
- Status of instances that are unhealthy at the time of check is **OutOfService**
- Load balancers send requests to only healthy instances. **When and instance is unhealthy, it stops routing requests to that instance**. It will resume the routing to instance as soon as it becomes healthy again

### Application Load Balancers (ALB)

- Layer 7 load balancing - Functions at Application layer of OSI model
- Listeners - Checks for connection requests from clients, using protocol and ports configured. Rules are defined to instruct load balancer to route the requests to registered targets. Each rule has a priority, one or more actions, one or more conditions
- Rules - If rules are met, its actions are performed. Each listener should have a default rule defined
- Target Groups - Each target group routes requests to one or more registered targets, such as EC2 instances
- Limitations - Only supports HTTP/HTTPS
- HTTPS - To use HTTPS load balancer, you should deploy at least one SSL/TLS server certificate on load balancer. The load balancer uses a server certificate to terminate the frontend connection and then decrypt requests from clients before sending them to the targets
- Allows load balancing based on contents of the request
- You can't assign an Elastic IP address to an Application Load Balancer. The alternative method you can do is assign an Elastic IP address to a Network Load Balancer in front of the Application Load Balancer.

### Network Load Balancers (NLB)

- **Layer 4 load balancing** and can handle millions of requests per second
- Attempts to open TCP connection to selected target on port specified in the listener configuration
- Listeners - Checks for connection requests from clients, using protocol and ports configured. There are no rules defined to instruct load balancer to route the requests to registered targets, unlike Application load balancers
- Cannot do intelligent routing, need to use Layer 7 based load balancer to do intelligent routing
- Target Groups - Each target group routes requests to one or more registered targets, such as EC2 instances
- **Protocols supported - UDP, TLS, TCP, TCP_UDP. Ports - 1-65535**
- Encryption - A TLS listener can be used to offload encryption and decryption to your load balancer, so applications can focus on business logic. An SSL certificate can be installed to the load balancer directly for decryption of traffic
- Use Cases - Best suited for TCP traffic **extreme performance requirement**, handling millions of requests per second with ultra low latencies
- It will send traffic to all the instances, if all instances are unhealthy, hoping one is online
- You can assign an Elastic IP address to an Network Load Balancer.

### Classic Load Balancers (CLB)

- Legacy load balancers (not being maintained and not recommended for use (deprecated)), used for HTTP/HTTPS applications and use Layer 7 features. Uses X-Forwarded and sticky sessions. Can also be used for applications that purely rely on TCP protocol
- **Gateway timeouts** - If application stops responding, the classic load balancer shall respond with **HTTP 504**. This means, either the web server or database server is not responding, but not the load balancer itself
- Internal load balancer is a private load balancer, and is not internet facing
- **[X-Forwarded-For](./X-Forwarded-For%20headers.png)** - Header used to get the IPv4 address of the end user coming via classic load balancer

### Sticky Sessions

- Classic load balancers route each request independently to registered EC2 instances with the smallest load. Sticky session allows to bind a user session to a specific EC2 instance. Can be used to **store the information locally** to that instance
- This ensures that all the requests from that user during session are sent to the same instance
- Limitation - If a user session is bound to an EC2 instance, and if it is removed (terminated) from the load balancer pool, then load balancer wont find the route that server and will result in error for that user. To fix it, sticky session need to be disabled
- Sticky session can be enabled for Application load balancers as well, but the traffic is sent at a target group level

### Deregistration Delay (Connection draining)

- **Allows load balancers to keep existing connections open if the EC2 instances are de-registered or become unhealthy**
- Enables the load balancer to complete in-flight requests made to instances that are de-registering or unhealthy
- This feature can disabled if existing connections are required to be closed immediately when instances are de-registered or have become unhealthy

### Exam Tips

- When you enable an Availability Zone for your load balancer, Elastic Load Balancing creates a load balancer node in the Availability Zone. If you register targets in an Availability Zone but do not enable the Availability Zone, these registered targets do not receive traffic. Your load balancer is most effective when you ensure that each enabled Availability Zone has at least one registered target.
- With an Application Load Balancer however, it is a requirement that you enable at least two or more Availability Zones
- After you disable an Availability Zone, the targets in that Availability Zone remain registered with the load balancer. However, even though they remain registered, the load balancer does not route traffic to them.
- You can host multiple TLS secured applications, each with its own TLS certificate, behind a single load balancer. In order to use SNI, all you need to do is bind multiple certificates to the same secure listener on your load balancer. ALB will automatically choose the optimal TLS certificate for each client. These features are provided at no additional charge.

### Samples
