# EBS

## Points

- Elastic Block Store
- Storage volumes can be attached to EC2 instances
- Designed for Mission critical data - Production workloads, Highly Available, Scalable

### General Purpose SSD (gp2)

- 3 IOPS per GB, upto max of 16000 IOPS per volume
- Volumes smaller than 1GB can burst upto 3000 IOPS
- Good for boot volumes or development and test applications that are not latency sensitive

### General Purpose SSD (gp3)

- Predictable 3000 IOPS baseline performance and 125 MiB/s regardless of volume size
- Ideal for applications that require high performance at a low cost, such as MySQL, Cassandra, Hadoop etc.
- Can scale up to 16000 IOPS
- Top performance of gp3 is 4 times faster than max throughput of gp2 volumes

### Provisioned IOPS SSD (io1)

- The high performance and most expensive option
- Upto 64000 IOPS per volume, 50 IOPS per GiB
- For workloads which require more than 16000 IOPS
- Designed for I/O intensive applications, large DBs and latency sensitive workloads

### Provisioned IOPS SSD (io2)

- Latest generation
- io2 is same price as of io1
- Upto 64000 IOPS per volume, 500 IOPS per GiB
- 99.999% durability instead of 99.9%
- Designed for I/O intensive applications, large DBs and latency sensitive workloads. Applications that need high level of durability

### Throughput Optimized HDD (st1)

- Lost cost HDD volume (Magnetic)
- Baseline throughput of 40 MB/s per TB
- Burst upto 250 MB/s per TB
- Maximum throughput 500 MB/s per volume
- Used for Big Data, data warehouses, ETL (Extract Transform and Load) and log processing
- Cannot be a boot volume

### Cold HDD (sc1)

- Lowest cost option
- Baseline throughput of 12 MB/s per TB
- Burst upto 80 MB/s per TB
- Maximum throughput 250 MB/s per volume
- A good choice for colder data which is requires fewer scans per day
- Used for a file server
- Used for applications that need the lowest cost and performance is not a factor

### Volumes

- Virtual Hard Disk

### Snapshots

- Stored on S3
- point-in-time copy of volumes
- Incremental in nature - Only data which is changed since last snapshot are moved to S3. Saves on space and time taken to take a snapshot
- First snapshot takes longer
- **Consistent Snapshots** - Snapshots only capture data which is written to EBS volume, which might exclude data cached locally by applications or OS. Recommended is to stop an EC2 instance and detach the EBS volume to take a snapshot
- **Encrypted Snapshots** - If EBS volume is encrypted, the snapshot will automatically be encrypted
- **Sharing Snapshots** - Snapshots can be shared between accounts and in regions. To share to other regions, will need to copy them to destination region first. Use Case - Copy EC2 instance to another region

### Encryption

- EBS encrypts volumes with a data key industry-standard AES-256 encryption algorithm
- Uses AWS Key Management Service (AWS KMS) customer master keys (CMK) when creating encrypted volumes and snapshots
- Data at rest is encrypted inside the volume
- Data in flight moving between volume and instance is encrypted
- All Snapshots of encrypted volumes are encrypted
- All volumes created from encrypted snapshots are encrypted
- Has minimal impact on latency
- Copying an un-encrypted snapshot allows encryption
- Root device volumes can be encrypted upon creation

## Exam Tips

- Designed for Mission critical data
  - Production workloads
  - Highly Available - replicated within a single AZ to protect against hardware failures
  - Scalable - dynamically increase capacity and change the volume type, with no downtime or performance impact
- General Purpose (gp2/gp3) - Used for boot volumes
- Top performance of gp3 is 4 times faster than max throughput of gp2 volumes
- io2 is same price as of io1
- gp2/gp3 - Used for boot volumes, high performance latency insensitive applications
- io1 - Used for I/O intensive applications, large DBs and latency sensitive workloads
- io2 - Used for I/O intensive applications, large DBs and latency sensitive workloads, with durability
- st2 - Used for Big Data, data warehouses, ETL (Extract Transform and Load) and log processing, cannot be a boot volume
- sc1 - Used for File servers, cannot be a boot volume
- Use Case
  - Transactions - io1/io2 / gp2/gp3
  - Data Warehouse, big data - st2
- gp2
  - Suitable for boot disks and general applications
  - Upto 16000 IOPS per volume
  - 99.9% durable
- gp3
  - Suitable for boot disks and high performance applications
  - Baseline performance 3000 IOPS and 125 MiB/s regardless of volume size
  - Upto 16000 IOPS per volume
  - 99.9% durable
- io1
  - Suitable for OLTP and latency sensitive applications
  - 50 IOPS per GB
  - Upto 64000 IOPS per volume
  - High performance and most expensive
  - 99.9% durable
- io2
  - Suitable for OLTP and latency sensitive applications
  - 500 IOPS per GB
  - Upto 64000 IOPS per volume
  - High performance and most expensive
  - 99.999% durable
- st1
  - Suitable for big data, data warehouses and ETL
  - Max throughput 500 MB/s per volume
  - Cannot be a boot volume
  - 99.9% durable
- sc1
  - Suitable less frequently accessed data
  - Max throughput 250 MB/s per volume
  - Cannot be a boot volume
  - Lowest cost
  - 99.9% durable
- Volumes - A virtual hard disk attached to EC2 instance, where OS can be installed or boot from
- Snapshots - Exist on S3, snapshot of volume - point-in-time copy of volume
- Location - EBS volumes will be same in AZ as of EC2 instance to which it is attached
- Resize on the fly - Instance is not required to be stopped or restarted, however volume will be required to extended in OS else OS won't detect
- Switch volume types on the fly - gp2 volume can be changed to io2 on the fly and instance is not required to be stopped or restarted

### Samples
