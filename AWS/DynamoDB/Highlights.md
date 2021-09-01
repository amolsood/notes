# DynamoDB

## Points

- Fast and flexible NoSQL database service for all applications that need consistent, single digit millisecond latency at any scale
- Supports both document and key-value data models
- Flexible data model and reliable performance makes it a great fit for mobile, gaming, IoT, web, ad-tech and many other apps
- Data stored on SSD storage
- Spread across 3 geographically distinct data centers
- Eventual consistency reads (default) - Copies of data is usually reached within a second (not immediate, eventual). Reading immediately after the write does not guarantee latest data while reading. Best read performance
- Support Strongly consistent reads - Returns a result that reflects all writes while reading, guarantees latest data while reading
- Pay-per-request pricing
- Encryption at rest using AWS KMS
- Site-to-Site VPN
- Direct Connect (DX)
- IAM policies and roles for fine grained access
- Integration with CloudWatch and CloudTrail
- VPC endpoints

### [DAX (DynamoDB Accelerator)](./DAX.png)

- Fully managed, highly available in-memory cache
- 10x performance improvement
- Reduces request time from milliseconds to microseconds, even under performance load
- No need to manage caching logic
- Compatible with DynamoDB APIs

### DynamoDB Transactions

- ACID with DynamoDB (All or nothing) across multiple tables within single AWS account and region
  - A - Atomicity - All or nothing - succeeds across all tables or fails as a whole
  - C - Consistency - Consistent before and after of transaction
  - I - Isolated - No other process can change while the transaction is running
  - D - Durable - Changes should persist after a transaction
- Use Cases
  - Financial Transactions
  - Fulfilling and managing orders
  - Multiplayer game engines
  - Coordinated actions across distributed system
- Eventual, Strong and Transactional consistency for reads
- Standard and Transactional consistency for writes
- Upto 25 items or 4MB of data

### [DynamoDB Streams](./Streams.png)

- Time-ordered sequence of item-level changes in table (FIFO)
- Stored for 24 hours
- Broken up into shards
- Records item-level inserts, deletes and updates
- Combine with lambda functions for functionality like stored procedures

### Global Tables

- Managed multi-region, multi-master replication
- Used for globally distributed applications
- Based on DynamoDB streams
- Multi-region redundancy for disaster recovery or high availability
- No application rewrites (built in DynamoDB)
- Replication latency under 1 second
- Streams need are required to be enabled to make a table global
- Table write capacity needs to be Pay-per-request or AutoScaled to have replicas created in another region

### Backups

- On demand
  - Full backups at any time
  - Zero impact on table performance or availability
  - Consistent within seconds and retained until deleted
  - Operates within same region as of source table
- Point in time recovery
  - Protects against accidental writes or deletes
  - Can restore to any point in last 35 days
  - Incremental backups
  - Not enabled by default
  - Latest restorable: 5 minutes in the past

## Exam Tips

- Data stored on SSD storage
- Spread across 3 geographically distinct data centers
- Eventual consistency reads (default) - Copies of data is usually reached within a second (not immediate, eventual). Reading immediately after the write does not guarantee latest data while reading
- Support Strongly consistent reads - Returns a result that reflects all writes while reading, guarantees latest data while reading
