# Big Data

## Points

- 3 V's
  - Volume - Ranges from TBs to PBs of data
  - Variety - Includes data from a wide range of sources and formats
  - Velocity - Data needs to be collected, stored, processed, analyzed within a short span of time

### Redshift

- Fully managed, petabyte scale data warehouse solution
- Its a very large relational database traditionally used in big data applications
- Size - It can hold up to 16PB of data (per cluster). No need to split large datasets
- Relational - This database is relational. Standard SQL and business intelligence (BI) tools are used
- Usage - Redshift is a fantastic BI tool, but cannot be used as a replacement to RDS database
- Node Types
  - RA3 - High performance with scalable managed storage
  - DC2 - High performance with fixed local SSD storage
  - DC2 (legacy) - Large workloads with fixed local HDD storage
- Default minimum node limit - 2
- Redshift is not a highly available service, as it runs in single AZ. For multiple AZs, multiple copies will be required
- Backups are kept for 1 day by default, but this can be raised up to 35 days at most

### [ElasticMapReduce](./EMRArchitecture.png) (EMR)

- EMR is managed big data platform (AWS's ETL (Extract, Transform, Load) tool) that allows to process vast amounts of data using open-source tools such as Spark, Hive, HBase, Flink, Hudi, Presto

### Kinesis

- Allows to ingest, process, and analyze real-time streaming data. Kind of a huge data highway connected to AWS account
- Versions
  - [Data Streams](./KinesisDataStreams.png)
    - Purpose - Realtime streaming for ingesting data
    - Speed - Realtime
    - Difficulty - Developer is responsible for creating consumer and scaling the stream
    - **A Kinesis data stream stores records from 24 hours by default to a maximum of 168 hours.**
  - [Data Firehose](./KinesisDataFirehose.png)
    - Purpose - Data transfer tool to get information to S3, Redshift, ES or Splunk
    - Speed - Near realtime (within 60 seconds)
    - Difficulty - Plug and play with AWS Architecture
  - Kinesis Data analytics
    - Its easy to tie Data Analytics into Kinesis pipeline. Directly supported by Data Firehose and Data Streams
    - Fully managed service, no management of servers, shards required. Automatically handles scaling and provisioning of needed resources
    - Only pay for amount of resources being used as data passes through

### [Athena and Glue](./AthenaAndGlue.png)

- Interactive query service that makes easy to analyze data in S3 using SQL
- Allows query data in S3 bucket without loading it into database
- Glue is a serverless data integration service that makes easy to discover, prepare and combine data. Allows to perform ETL workloads without managing underlying servers (Kind of replaces EMR)
- Required when looking for serverless SQL solution. Only service that allows to directly query on data stored in S3

### QuickSight (Visualize data)

- Fully managed BI data visualization service.
- Allows to create dashboards and share them within company
- Required when sharing the data, interpreting that data, or anything related to BI

### ElasticSearch (Search Engine)

- Fully managed service, version of open-source application ElasticSearch
- Allows to search over the data and analyze the data.
- Commonly used as a part of an ElasticSearch, Logstash, Kibana (ELK) stack

## Exam Tips

- Redshift is a fully managed, petabyte scale data warehouse solution. It can hold up to 16PB of data
- Not standard, should not be used in place of RDS
- Redshift is a relational database
- Redshift Backups are kept for 1 day by default, but this can be raised up to 35 days at most
- EMR is a managed fleet of EC2 instances running open-source tools. Similar to other open-source managed architecture in that it gets the fleet up and running quickly, but the technology is not proprietary to AWS
- EC2 rules apply to EMR. RIs and Spot instances can be used to reduce costs
- **When we are looking for message-broker service, what options to choose from**
  - SQS - Simple to use and doesn't require much configuration, but does not offer realtime message delivery
  - Kinesis - More complicated to configure, mostly used in big data applications, but does provide realtime communication
- Realtime - Kinesis Data Streams
- Realtime* (Near realtime) - Kinesis Firehose
- Transform flowing data in streams using SQL - Kinesis Data Analytics
- Data Streams does not automatically scale, Data firehose does
- Athena and Glue are serverless (managed) services
- While Athena can work by itself, Glue can design a schema for data

### Samples
