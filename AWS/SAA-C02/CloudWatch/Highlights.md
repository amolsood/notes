# CloudWatch

## Points

- **Monitoring and observability platform**
- Features
  - System Metrics - CPU, RAM, etc. The more the service managed is, the more the details we get out of the box
  - Application Metrics - Installing CloudWatch agent to EC2 services, to measure the metrics on application level
  - Alarms - Alarms alerts based on conditions
  - Actions - Based on alarms, actions can be taken
- [Metrics](./Metrics.png)
  - Default - Metrics provided out of the box and do not require any additional configuration
  - Custom - These metrics will need to be provided by using CloudWatch agent installed on the host

### Metrics

- Default metric period for alarms - 1 minute

### CloudWatch Logs

- Allows to monitor, store and access log files from different sources/services
- Gives ability to query logs for relevant data
- Terms
  - Log Event - Record of what happened, contains **timestamp** and the **data**
  - Log Stream - Collection of Log events from same/particular source
  - Log Group - Collection of log streams
- Features
  - Filter Patterns - Can look for specific terms in logs. Example - 400 errors in web server logs
  - Logs Insights - Allows SQL-like commands to query all logs
  - Alarms - Once the pattern is identified, alarm can alert about the same

## Exam Tips

- Used for **monitoring**
- There are no default alarms
- AWS cannot see past through hypervisor level for EC2 instances, means, it can only give high level metrics for an instance
- The more the service managed is, the more the details we get out of the box
- Standard metrics is 5-minute interval, whereas, Detailed metrics is 1-minute interval
- Logs go to CloudWatch logs, except for situations where we don't need to process them, then should go straight to S3
- For logs, favor cloudwatch logs unless exam asks for a real-time solution (Kinesis)
- CloudWatch alarms can be used to alert if the filter patterns are found
- The CloudWatch agent must be installed and configured, it's not automatic
- Search for logs using SQL-like queries on CloudWatch Logs Insights
- CloudWatch is the tool for anything alarm related
- Not everything should go through CloudWatch - AWS standards should be watched by AWS Config
- Know the intervals - The default (standard) metrics are delivered every 5 minutes (Free), but the detailed metrics are delivered every 1 minute (Additional Charge)
- CloudWatch Logs are not realtime (near realtime). For realtime use Kinesis
- A period is the length of time associated with a specific Amazon CloudWatch statistic. Each statistic represents an aggregation of the metrics data collected for a specified period of time. Periods are defined in numbers of seconds, and valid values for period are 1, 5, 10, 30, or any multiple of 60. For example, to specify a period of six minutes, use 360 as the period value. You can adjust how the data is aggregated by varying the length of the period. A period can be as short as one second or as long as one day (86,400 seconds). The default value is 60 seconds.
- You can create an Amazon CloudWatch alarm that monitors an Amazon EC2 instance and automatically reboots the instance.
- For RDS, Take note that there are certain differences between CloudWatch and Enhanced Monitoring Metrics. CloudWatch gathers metrics about CPU utilization from the hypervisor for a DB instance, and Enhanced Monitoring gathers its metrics from an agent on the instance. Enable Enhanced Monitoring in RDS allows to monitor CPU and Memory for an agent from instance

### Samples

Installation of cloudwatch-agent

  ```sh
  sudo yum install amazon-cloudwatch-agent -y
  ```

Configuration of cloudwatch-agent

  ```sh
  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json
  ```
