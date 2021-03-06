# RDS (Relational Database Service)

## Points

- Organized in Tables, within a database
- Data Items in rows
- Fields in Columns
- MS SQL server, MySQL, PostgreSQL, Oracle, MariaDB, Amazon Aurora
- RDS is an EC2 instance without access to the OS
  - Multi-AZ (Primary DB in one zone, and secondary DB in another)
  - Failover capability (Failover to another instance in another region)
  - Automated backups
- Generally used for OLTP (Online Transaction Processing)
- Not suitable for OLAP. Data warehouse like Redshift is optimized for OLAP
- Automatic RDS backup can be stored for 35 days at most

### [Multi-AZ RDS](./Multi-AZ%20RDS.png) (Sync)

- Works only for production instances
- Creates an exact copy of database in another AZ, not in all AZs
- MS SQL server, MySQL, PostgreSQL, Oracle, MariaDB can be configured as Multi-AZ RDS instance
- **Amazon Aurora is always Multi-AZ**
- Only for disaster recovery and not for improving performance
- Amazon RDS simply flips the canonical name record (CNAME) for your DB instance to point at the standby, which is in turn promoted to become the new primary.
- Backups are taken from secondary copy of data
- All updates or maintenance changes are applied to the secondary database. You then cut over to that secondary copy of your data.
- If your primary database fails, you'll automatically fail over to the secondary copy.

### FailOver

- RDS will automatically failover to the standby DB, so that database operations can resume quickly without any administrative intervention or re-configuration

### [Read Replicas](./Read%20Replica.png) (Async)

- A read-replica is a read-only copy of the primary database (Read-only)
- Used to scale read performance only and not for disaster management
- Requires automatic backup to be enabled
- Great for ready-heavy workloads and it takes off load from primary database
- It can be cross AZ and cross region
- Each replica has its own DNS endpoint
- Read replicas can be promoted to be their own databases, but it breaks the replication (Read-Write)
- MS SQL server, MySQL, PostgreSQL, Oracle, MariaDB allows upto 5 replicas for each DB instance

### OLTP vs OLAP

- OLTP - Online Transaction Processing
  - Processing and completing large number of small transactions in realtime
  - e.g orders, banking transactions, payments, etc
- OLAP - Online Analytical Processing
  - Data analysis using large amounts of data as well as complex queries that take long time to complete
  - e.g - Analyzing net profits from past 3 years and sales forecasting

### Aurora

- Proprietary database from AWS, **compatible with MySQL and PostgreSQL**
- 5 times better performance than MySQL and 3 times better performance than PostgreSQL at lower price point
- Starts with 10GB and auto scales. Scales in 10GB increments upto 128TB (storage scaling)
- Can scale upto 96 vCPUs and 768GB or memory (compute scaling)
- 2 copies of data contained in each availability zone, with a minimum of 3 availability zones. Total 6 copies of data
- Can handle with same write availability even if 2 copies are lost and read availability if 3 copies are lost
- Storage is self-healing, any errors in disks are regularly scanned and repaired automatically
- Replicas available
  - Aurora - 15 replicas
  - MySQL - 5 replicas
  - PostgreSQL - 5 replicas
- Automated backups are always enabled and do not impact DB performance
- Can take snapshots with Aurora, no performance impact
- Snapshots can be shared with other AWS accounts
- Aurora Serverless also incurs no compute costs when it is idle.
- A **reader endpoint** for an Aurora DB cluster provides load-balancing support for read-only connections to the DB cluster. Use the reader endpoint for read operations, such as queries. By processing those statements on the read-only Aurora Replicas, this endpoint reduces the overhead on the primary instance. It also helps the cluster to scale the capacity to handle simultaneous SELECT queries, proportional to the number of Aurora Replicas in the cluster. Each Aurora DB cluster has one reader endpoint.
- If the cluster contains one or more Aurora Replicas, the reader endpoint load-balances each connection request among the Aurora Replicas. In that case, you can only perform read-only statements such as SELECT in that session. If the cluster only contains a primary instance and no Aurora Replicas, the reader endpoint connects to the primary instance. In that case, you can perform write operations through the endpoint.

### Aurora Serverless

- An on-demand, auto scaling configuration for MySQL and PostgreSQL editions of Aurora
- The cluster automatically starts up, shuts down and scales capacity up or down based on application needs
- Use cases
  - Simple and Cost effective solution for infrequent, intermittent and unpredictable workloads

## Exam Tips

- MS SQL server, MySQL, PostgreSQL, Oracle, MariaDB, Amazon Aurora
- RDS is for OLTP workloads
- AWS patches and updates your RDS databases
- Not suitable for OLAP, use Redshift for data warehousing
- Multi-AZ
  - Exact copy of production database in another AZ (not all AZs in that region)
  - Used for disaster recovery
  - Automatic failover to standby instance, Configuration managed by AWS in case of failover
- Read Replica
  - A read only copy of primary database in same AZ, cross AZ or cross region
  - Used for performance scalability
  - Offloads read heavy operations to replica and frees up primary instance
  - e.g - Business intelligence, reporting jobs
- Aurora
  - 2 copies of data contained in each availability zone, with a minimum of 3 availability zones. Total 6 copies of data
  - Automated backups are always enabled and do not impact DB performance
  - Can take snapshots with Aurora, no performance impact
  - Snapshots can be shared with other AWS accounts
  - Replicas available
    - Aurora - 15 replicas
    - MySQL - 5 replicas
    - PostgreSQL - 5 replicas
  - Automated failover is only available with Aurora replicas
  - **AWS Database Migration Service** helps you migrate databases to AWS quickly and securely. The source database remains fully operational during the migration, minimizing downtime to applications that rely on the database. The AWS Database Migration Service can migrate your data to and from the most widely used commercial and open-source databases.
  - AWS Database Migration Service supports homogeneous migrations such as Oracle to Oracle, as well as heterogeneous migrations between different database platforms, such as Oracle or Microsoft SQL Server to Amazon Aurora. With AWS Database Migration Service, you can continuously replicate your data with high availability and consolidate databases into a petabyte-scale data warehouse by streaming data to Amazon Redshift and Amazon S3. Learn more about the supported source and target databases. https://aws.amazon.com/dms/
