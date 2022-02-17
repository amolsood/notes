# Caching

## Points

- Caching Solutions
  - CloudFront
  - ElastiCache
  - DAX (DynamoDB Accelerator)
  - Global Accelerator
- Internal Cache - That can be put in front of Databases
- External Cache - Cache data which can be returned to users

### [CloudFront](./CloudFront.png)

- Content Delivery Network (CDN) service that securely delivers data, videos, applications, etc
- Helps reduce latency and provide higher transfer speeds using AWS Edge Locations
- Security - Defaults to HTTPS protocol with ability to add customer SSL certificates
- Global Distribution - Cannot pick specific location, just the general areas of the globe
- Endpoint support - Can be used to front AWS endpoints along with non AWS applications
- Expiring Content - Force an expiration of content from the cache if you can't wait for the TTL

### ElastiCache and DAX

- Managed version of 2 open-source services, Memcached and Redis. Neither of these tools are AWS specific
- Memcached
  - Simple database caching solution
  - Not a database by itself,
  - No failover support or Multi-AZ support
  - No backups
- Redis
  - Supported as a caching solution
  - Functions as a standalone database (NoSQL)
  - Failover and Multi-AZ support
  - Supports backups
- DAX
  - In-Memory Cache - Can reduce DynamoDB response times from milliseconds to microseconds
  - Lives inside a VPC - Cache is highly available
  - Control - Can determine the node size and count for the cluster, TTL for data, and maintenance windows for changes and updates
- **DAX is only for DynamoDB**
- Elasticache gives a bit more flexibility as it is independent of the service and can be put with variety of services, but really excels in front of RDS

### [Global Accelerator](./GlobalAccelerator.png)

- Is a networking service that sends your traffic via AWS global network infrastructure
- Can increase performance and help deal with IP caching
- IP caching - In this, if Global accelerator is not used, the user caches the IP address of the load balancer, now if the load balancer goes down and replaced by another one, the user will stick to the same IP address until TTL, and won't be serviced. Global accelerator solves that, as it provides static IPs to users when placed in front, even if any of the load balancers/services goes offline inside the architecture, so user is always going to request the same IP and will always get response
- Helps to mask complex architecture - As the application grows, the architecture changes, and user won't even notice as they will always reach the same IP address
- Speeds things up - Traffic is routed via AWS global network infrastructure

## Exam Tips

- Wherever possible, pick option that includes caching solution
- Caches go in front of everything
- Helps with Speed and performance
- Internal vs External
- CloudFront
  - Every external customer performance issue can be resolved by putting CloudFront in front of application
  - Slow connectivity, slow loading of images, videos, content, put cloudfront
  - Speedy - Cache content at the edge locations to speed up delivery of data
  - On-site support - This CDN works for both AWS and on-site architecture
  - Blocking Connections - Can be used to block individual countries, but WAF is a better tool to do the same
  - Edge-locations - Cannot pick specific edge locations for distributions, all locations are recommended
- Favor answers that include a database caching solution
- Memcached and DAX are just a cache, but Elasticache can be used a standalone database solution
- Global Accelerator
  - If scenario talks about IP Caching, think Global accelerator
  - Speeds it up - It uses edge locations to help speed everything up
  - Weighting - Easily create different weighted groups in each region architecture lives in
  - Provided wit 2 static IPs that don't change, can setup own IP Addresses too

### Samples
