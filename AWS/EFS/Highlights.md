# EFS (Elastic File System)

## Points

- Shared Storage
- Managed NFS (Network file system) which can be attached to multiple EC2 instances
- EFS works with EC2 instances in multiple AZs
- Highly available and Scalable, but expensive
- Use Cases
  - Content management - shared content between EC2 instances
  - Web Server - Single folder structure for a website
- Uses NFSv4 protocol
- Compatible with Linux AMI (Windows not yet supported)
- Encryption at rest using AWS KMS
- Automatic scaling, no capacity planning required
- Pay per use, that's wy expensive
- Performance
  - Can support 1000s concurrent connections (EC2 instances)
  - 10 Gbps throughput
  - Scaling upto Petabytes
- Performance control
  - General Purpose - Used for Web servers, content management, etc
  - Max I/O - Used for big data, media processing, etc
- Supports lifecycle management, allowing to move data from one tier to another after x days
- Storage Tiers
  - Standard - For frequent access
  - Standard IA storage - For infrequent access
  - One Zone
  - One Zone IA storage
  - Infrequent Access requests
  - Provisioned Throughput - Most Expensive


## Exam Tips

- Support NFSv4
- pay per use
- scale upto petabytes
- can support 1000s of concurrent NFS connections
- Data is stored across multiple AZs across a region
- Read-after-write consistency
- Use Case
  - Highly scalable shared file system using NFS
