# Route 53

## Points

- DNS Service
- Lookup - Used to convert a human-friendly domain name (website) into an IP Address
- Supports
  - IPv4 - 32-bit address - 4 billion possible addresses
  - IPv6 - 128-bit address - 340 undecillion (10^36) possible addresses
- Top level domains names are controlled by [IANA](http://www.iana.org/domains/root/db) (Internet Assigned Numbers Authority) in a root zone database (a database of all available top-level domains)
  - bbc.co.uk
    - uk - top-level domain
    - co - second-level domain
    - bbc - name
  - Top-level domain
    - .gov
    - .gov.uk
    - .edu
    - .com.au
- Domain Registrar is an authority that can assign domain names directly under one or more top-level domains. The domains are registered with InterNIC, a service of ICANN, which enforces uniqueness of domain names across internet, and stored in central database called **WHOIS database**
  - GoDaddy
  - domain.com
  - Hoover
  - AWS
  - Namecheap
- SOA Record (Start of Authority)
  - Provides
    - Name of server that supplied the data for that zone
    - Administrator of that zone
    - Current version of the data file
    - Default number of seconds for the time-to-live file on resource records
- NS records (name server records) - Used by top-level domain servers to direct traffic to the content DNS server that contains the authoritative DNS records
- A (address) record - Is a fundamental type of DNS record and used by computer to translate the name of domain to an IP Address
- TTL - The length of DNS record to be cached on resolving server on user own local PC. The lower the TTL, the faster changes to DNS records take to propagate throughout the internet. Default to 300 seconds
- CNAME - Canonical name, can be used to resolve one domain name to another. E.g m.facebook.com when used on mobile device and facebook.com when used on computer.
- Alias Records - Used to map resource record sets in a hosted zone to load balancers, cloudfront distributions, or S3 buckets that are configured as websites. Works like CNAME, a DNS name can be mapped to another "target" DNS name.
- **CNAME cannot be used for naked domain names (zone apex records), e.g - Cannot have CNAME for google.com**
- **A record/Alias can be used for naked domain names**
- Domain names can directly be bought on AWS, can take upto 3 days to register depending on circumstances

### Routing Policies

- Simple Routing
- Weighted Routing
- Latency-Based Routing
- Failover Routing
- Geolocation Routing
- Geoproximity Routing (Traffix flow only)
- MultiValue Answer Routing

### DNS Record Types

- SOA Records
- CNAME Records
- NS Records
- A Records

### [Simple Routing Policy](./SimpleRoutingPolicy.png)

- **Only one record can be mapped with multiple IP Addresses**
- With simple routing, you typically route traffic to a single resource, for example, to a web server for your website.
- If **multiple values are specified in a record**, Route 53 returns **all the values (IP Address)** in **random order** to the user (any of them for each request)

### [Weighted Routing Policy](./WeightedRoutingPolicy.png)

- Allows to split traffic based on weights
- Example - 10% of load can be directed to Server 1, and 90% to another Server 2
- Health checks can be set on **individual** record sets
- If a record set fails a health check, it will removed from Route 53 until it passes the health check and all traffic will be directed to another server
- SNS notifications can be set to **alert** for health check failures
- A weight can be a number between 0 and 255. If specified 0, Route 53 will stop responding to DNS queries using this record

### [Failover Routing Policy](./FailOverRoutingPolicy.png)

- Used to create active/passive (primary/secondary) set up
- If health check fails on primary record, it will fail-over to secondary record

### [Geolocation Routing Policy](./GeolocationRoutingPolicy.png)

- Lets choose where the traffic will be sent based on geographic location of users
- Use Case - All queries to be routed to a fleet of EC2 instances setup in Europe for European customers

### Geoproximity Routing Policy

- Uses combination of geolocation, latency, and availability to route traffic
- Only available under when using Route 53 Traffic flow
- A bias can be set to route more or less traffic to given resource
- A bias shrinks or expands the size of geographic region

### [Latency Routing Policy](./LatencyRoutingPolicy.png)

- Allow to route traffic based on the lowest network latency for end user

### Multivalue Answer Routing Policy

- Lets you configure Route 53 to return multiple values
- Route 53 only returns values for healthy resources
- Similar to simple routing policy however it allows to put health checks on each record set

## Exam Tips

- Route 53 is global
- Given the choice, always choose alias over CNAME.
- Domain names can be bought from AWS, can take upto 2-3 days to registration
- Health checks can be set on individual record sets. If a record set fails a health check, it will be removed from Route 53 remove until health check passes
- SNS alerts can be set to notify for a failed health check
- All routing policies

### Samples

- http://www.iana.org/domains/root/db